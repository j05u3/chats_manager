import 'package:chats_manager/api/bot_server_api.dart';
import 'package:chats_manager/firestore/messaging_backend.dart';
import 'package:chats_manager/models/bot_server_api/messages_api_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:chats_manager/models/messages.dart' as msgTypes;

import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../models/users.dart';
import '../utils/chat_ui_converters.dart';
import '../utils/toast_util.dart';

class ChatWidget extends StatefulWidget {
  final User user;
  final String botId;
  const ChatWidget({super.key, required this.user, required this.botId});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) => StreamBuilder<List<msgTypes.Message>>(
      initialData: const [],
      stream: MessagingBackend.instance.messages(widget.user.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Chat(
          messages: (snapshot.data ?? [])
              .where((message) {
                final botPhoneNumberId =
                    message.incomingMessage?.toPhoneNumberId ??
                        message.outgoingMessage?.fromPhoneNumberId;
                return botPhoneNumberId == widget.botId;
              })
              .map((e) => convertMessageToChatMessage(e))
              .toList(),
          onAttachmentPressed: _handleAtachmentPressed,
          onMessageTap: _handleMessageTap,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: types.User(
            id: widget.botId,
          ),
          imageMessageBuilder: (message, {required messageWidth}) {
            return Column(
              children: [
                ImageMessage(
                  message: message,
                  messageWidth: messageWidth,
                ),
                if (message.name.isNotEmpty) Text(message.name),
              ],
            );
          },
        );
      });

  void _handleSendPressed(types.PartialText message) async {
    await (await BotServerApiClient.getClient()).sendTextMessage(
      SendMessageRequest(
        from: widget.botId,
        to: widget.user.id,
        msg: message.text,
      ),
    );
  }

  void _handleMessageTap(BuildContext context, types.Message p1) {
    if (p1 is types.ImageMessage) {
      Clipboard.setData(ClipboardData(text: p1.uri.toString()));
      toast("Image link copied to clipboard ✌️");
      return;
    }
    Clipboard.setData(ClipboardData(text: p1.author.id));
    toast("User phone number copied to clipboard ✌️");
  }

  void _handleAtachmentPressed() {
    toast("Not implemented yet");
  }
}
