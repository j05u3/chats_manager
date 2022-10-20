import 'package:collection/collection.dart';
import 'package:chats_manager/models/messages.dart';
import 'package:chats_manager/models/users.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream_transform/stream_transform.dart';

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

  CollectionReference get userMessageStatusCollection =>
      firestore.collection("user_message_status");

  CollectionReference get userMessagingProfileCollection =>
      firestore.collection("user_messaging_profile");

  CollectionReference get incomingMessagesCollection =>
      firestore.collection("incoming_messages");

  CollectionReference get outgoingMessagesCollection =>
      firestore.collection("outgoing_messages");

  Stream<List<types.User>> users() {
    return userMessageStatusCollection
        .orderBy("last_message_timestamp", descending: true)
        .snapshots()
        .combineLatest(userMessagingProfileCollection.snapshots(),
            (statusesSnapshot, profilesSnapshot) {
      return statusesSnapshot.docs.map((status) {
        final profile = profilesSnapshot.docs
            .firstWhereOrNull((profile) => profile.id == status.id);
        return types.User(
            id: status.id,
            profile: profile == null
                ? (types.UserMessagingProfile()..name = "")
                : types.UserMessagingProfile.fromJson(
                    profile.data() as Map<String, dynamic>),
            status: types.UserMessageStatus.fromJson(
                status.data() as Map<String, dynamic>));
      }).toList();
    });
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
    return incomingMessages(userId).combineLatest(outgoingMessages(userId),
        (incomingMessages, outgoingMessages) {
      final messages = <Message>[];
      messages.addAll(incomingMessages
          .map((e) => Message(id: e.id!, t: e.t!, incomingMessage: e)));
      messages.addAll(outgoingMessages.map((e) => Message(
          id: e.responseSummary!.messageId!, t: e.t!, outgoingMessage: e)));

      // sort by timestamp in descending order
      messages.sort((a, b) => b.t!.compareTo(a.t!));

      return messages;
    });
  }
}
