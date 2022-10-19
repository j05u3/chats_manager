import 'package:async/async.dart';
import 'package:chats_manager/models/messages.dart';
import 'package:chats_manager/models/users.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Provides access to Firebase chat data. Singleton, use
/// MessagingBackend.instance to aceess methods.
class MessagingBackend {
  MessagingBackend._privateConstructor();

  /// Current logged in user in Firebase.
  User? get firebaseUser => FirebaseAuth.instance.currentUser;

  /// Singleton instance.
  static final MessagingBackend instance =
      MessagingBackend._privateConstructor();

  /// Gets proper [FirebaseFirestore] instance.
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// Gets the users message status collection.
  CollectionReference get userMessageStatusCollection =>
      firestore.collection("user_message_status");

  CollectionReference get incomingMessagesCollection =>
      firestore.collection("incoming_messages");

  CollectionReference get outgoingMessagesCollection =>
      firestore.collection("outgoing_messages");

  Stream<List<types.User>> users() {
    // if (firebaseUser == null) return const Stream.empty();
    return userMessageStatusCollection
        .orderBy("last_message_timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<types.User>>(
            [],
            (previousValue, doc) {
              return [
                ...previousValue,
                types.User(
                    id: doc.id,
                    status: types.UserMessageStatus.fromJson(
                        doc.data() as Map<String, dynamic>))
              ];
            },
          ),
        );
  }

  Stream<List<IncomingMessage>> incomingMessages(String userId) {
    // if (firebaseUser == null) return const Stream.empty();
    return incomingMessagesCollection
        .where("from", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<IncomingMessage>>(
            [],
            (previousValue, doc) {
              return [
                ...previousValue,
                IncomingMessage.fromJson(doc.data() as Map<String, dynamic>)
              ];
            },
          ),
        );
  }

  Stream<List<OutgoingMessage>> outgoingMessages(String userId) {
    // if (firebaseUser == null) return const Stream.empty();
    return outgoingMessagesCollection
        .where("responseSummary.phoneNumber", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<List<OutgoingMessage>>(
            [],
            (previousValue, doc) {
              return [
                ...previousValue,
                OutgoingMessage.fromJson(doc.data() as Map<String, dynamic>)
              ];
            },
          ),
        );
  }

  Stream<List<Message>> messages(String userId) {
    return StreamZip([
      incomingMessages(userId),
      outgoingMessages(userId),
    ]).map((event) {
      final incoming = (event[0] as List<IncomingMessage>)
          .map((e) => Message(id: e.id!, t: e.t!, incomingMessage: e));
      final outgoing = (event[1] as List<OutgoingMessage>).map((e) => Message(
          id: e.responseSummary!.messageId!, t: e.t!, outgoingMessage: e));
      final messages = [
        ...incoming,
        ...outgoing,
      ];
      // sort by timestamp in descending order
      messages.sort((a, b) => b.t!.compareTo(a.t!));      
      return messages;
    });
  }
}
