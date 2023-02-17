// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart'; // for the extension method IterableExtension.firstWhereOrNull
import 'package:chats_manager/models/users.dart' as types;
import 'package:chats_manager/models/messages.dart' as msgTypes;
import 'package:flutter_chat_types/flutter_chat_types.dart';

import '../private_constants.dart';

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

  final status = isIncoming
      ? null
      // Note: order matters in the evaluation
      : (message.outgoingMessage?.lastStatus_failed != null
          ? Status.error
          : (message.outgoingMessage?.lastStatus_read != null
              ? Status.seen
              : (message.outgoingMessage?.lastStatus_delivered != null
                  ? Status.delivered
                  : (message.outgoingMessage?.lastStatus_sent != null
                      ? Status.sent
                      : Status.sending))));

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

    // search for the template on the template list
    final templateName =
        templates.firstWhereOrNull((element) => element["id"] == template.name);

    final text =
        '[t] ${templateName == null ? '[${template.name}] ${texts?.join("\n") ?? ""}' : templateName["text"]!.replaceAllMapped(RegExp(r'\{\{(\d+)\}\}'), (match) {
            final index = int.parse(match.group(1) ?? "0") - 1;
            if (texts == null) return "";
            if (texts.length <= index) return "";
            if (index < 0) return "";
            return texts[index] ?? "";
          })}';

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
        status: status,
      );
    }

    return TextMessage.fromPartial(
      createdAt: message.t,
      author: author,
      id: message.id,
      partialText: PartialText(
        text: text,
      ),
      status: status,
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
      status: status,
    );
  }

  // file sent
  if (message.outgoingMessage?.requestBody?.document != null) {
    // TODO: maybe use the FileMessage widget

    final docLink = message.outgoingMessage?.requestBody?.document?.link ?? "";
    final filename =
        message.outgoingMessage?.requestBody?.document?.filename ?? "";

    return TextMessage.fromPartial(
      createdAt: message.t,
      author: author,
      id: message.id,
      partialText: PartialText(
        text: "File: $filename\nLink: $docLink",
      ),
      status: status,
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
        status: status,
      );
    }

    return TextMessage.fromPartial(
      createdAt: message.t,
      author: author,
      id: message.id,
      partialText: PartialText(
        text: "$mime_type\n$media_url",
      ),
      status: status,
    );
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
    status: status,
  );
}

String buildLocationTextFromLocation(msgTypes.Location location) {
  final lat = location.latitude!.toString();
  final lon = location.longitude!.toString();
  return buildLocationText(lat, lon);
}

String buildLocationText(String lat, String lon) {
  return "📍 $lat, $lon \nLink for easy lookup: https://maps.google.com/?q=$lat,$lon";
}
