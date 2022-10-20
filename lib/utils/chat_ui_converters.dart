import 'package:chats_manager/models/users.dart' as types;
import 'package:chats_manager/models/messages.dart' as msgTypes;
import 'package:flutter_chat_types/flutter_chat_types.dart';

User convertUserToChatUser(types.User user) {
  return User(
    id: user.id,
    lastSeen: user.status.lastIncomingMessageTimestamp,
    firstName: user.profile.name,
  );
}

TextMessage convertMessageToChatMessage(msgTypes.Message message) {
  final isIncoming = message.incomingMessage != null;
  final senderId = message.incomingMessage?.from ??
      message.outgoingMessage?.fromPhoneNumberId ??
      "";
  final senderName = (isIncoming
          ? (message.incomingMessage?.name ?? message.incomingMessage?.from)
          : message.outgoingMessage?.fromPhoneNumberId) ??
      "";
  return TextMessage.fromPartial(
    createdAt: message.t,
    author: User(firstName: senderName, id: senderId),
    id: message.id,
    partialText: PartialText(
        text: (message.incomingMessage?.data?.text ??
            message.incomingMessage?.data?.title ??
            message.outgoingMessage?.requestBody?.text?.body ??
            message.outgoingMessage?.requestBody?.template?.name ??
            message.outgoingMessage?.requestBody?.interactive?.body?.text ??
            (message.outgoingMessage?.requestBody?.location != null
                ? message.outgoingMessage!.requestBody!.location!.latitude!
                        .toString()! +
                    ", " +
                    message.outgoingMessage!.requestBody!.location!.longitude!
                        .toString()!
                : null) ??
            "")),
  );
}
