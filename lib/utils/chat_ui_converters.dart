// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart'; // for the extension method IterableExtension.firstWhereOrNull
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

Message convertMessageToChatMessage(msgTypes.Message message) {
  final isIncoming = message.incomingMessage != null;
  final senderId = message.incomingMessage?.from ??
      message.outgoingMessage?.fromPhoneNumberId ??
      "";
  final senderName = (isIncoming
          ? (message.incomingMessage?.name ?? message.incomingMessage?.from)
          : message.outgoingMessage?.fromPhoneNumberId) ??
      "";

  final author = User(firstName: senderName, id: senderId);

  // template sent
  if (message.outgoingMessage?.requestBody?.template != null) {
    final template = message.outgoingMessage!.requestBody!.template!;

    // search for the 'header' component
    final header = template.components
        ?.firstWhereOrNull((element) => element.type == "header");

    // search for the 'image' parameter on the header
    final image = header?.parameters
        ?.firstWhereOrNull((element) => element.type == "image");

    // search for the 'body' component
    final body = template.components
        ?.firstWhereOrNull((element) => element.type == "body");

    // get all the 'text' parameters on the body
    final texts = body?.parameters
        ?.where((element) => element.type == "text")
        .map((e) => e.text!)
        .toList();

    final text = '[${template.name}] ${texts?.join("\n") ?? ""}';

    if (image?.image?.link != null) {
      final imageLink = image!.image!.link!;
      return ImageMessage.fromPartial(
        createdAt: message.t,
        author: author,
        id: message.id,
        partialImage: PartialImage(
          uri: imageLink,
          name: text,
          size: 0,
        ),
      );
    }

    return TextMessage.fromPartial(
      createdAt: message.t,
      author: author,
      id: message.id,
      partialText: PartialText(
        text: text,
      ),
    );
  }

  // image sent
  if (message.outgoingMessage?.requestBody?.image != null) {
    final imageLink = message.outgoingMessage?.requestBody?.image?.link ?? "";

    return ImageMessage.fromPartial(
      createdAt: message.t,
      author: author,
      id: message.id,
      partialImage: PartialImage(
        uri: imageLink,
        name: "",
        size: 0,
      ),
    );
  }

  // media received
  if (message.incomingMessage?.data?.media_url != null) {
    final mime_type = message.incomingMessage!.data!.mime_type!;
    final media_url = message.incomingMessage?.data?.media_url ?? "";

    if (mime_type.startsWith("image")) {
      return ImageMessage.fromPartial(
        createdAt: message.t,
        author: author,
        id: message.id,
        partialImage: PartialImage(
          uri: media_url,
          name: "",
          size: 0,
        ),
      );
    }
  }

  return TextMessage.fromPartial(
    createdAt: message.t,
    author: author,
    id: message.id,
    partialText: PartialText(
        text: (message.incomingMessage?.data?.text ??
            message.incomingMessage?.data?.title ??
            (message.incomingMessage?.data?.latitude != null
                ? buildLocationText(
                    message.incomingMessage!.data!.latitude!.toString(),
                    message.incomingMessage!.data!.longitude!.toString())
                : null) ??
            message.outgoingMessage?.requestBody?.text?.body ??
            message.outgoingMessage?.requestBody?.interactive?.body?.text ??
            (message.outgoingMessage?.requestBody?.location != null
                ? buildLocationTextFromLocation(
                    message.outgoingMessage!.requestBody!.location!)
                : null) ??
            "")),
  );
}

String buildLocationTextFromLocation(msgTypes.Location location) {
  final lat = location.latitude!.toString();
  final lon = location.longitude!.toString();
  return buildLocationText(lat, lon);
}

String buildLocationText(String lat, String lon) {
  return "📍 $lat, $lon (link for easy lookup: https://maps.google.com/?q=$lat,$lon)";
}
