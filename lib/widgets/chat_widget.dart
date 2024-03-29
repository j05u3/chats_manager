import 'package:chats_manager/api/bot_server_api.dart';
import 'package:chats_manager/firestore/messaging_backend.dart';
import 'package:chats_manager/models/bot_server_api/messages_api_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:chats_manager/models/messages.dart' as msgTypes;

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';

import '../models/users.dart';
import '../utils/chat_ui_converters.dart';
import '../utils/toast_util.dart';

const uuid = Uuid();

class ChatWidget extends StatefulWidget {
  final User user;
  final String botId;
  const ChatWidget({super.key, required this.user, required this.botId});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool _isAttachmentUploading = false;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<msgTypes.Message>>(
      initialData: const [],
      stream: MessagingBackend.instance.messages(widget.user.id)
      // .handleError((error, st) {  // just to see the stack trace in case of errors
      //   debugPrintStack(stackTrace: st);
      // }, test: (e) => true)
      ,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
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
          onAttachmentPressed: _handleAttachmentPressed,
          isAttachmentUploading: _isAttachmentUploading,
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
    await (await BotServerApiClient.getClient()).sendMessage(
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

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      try {
        final mimeType = lookupMimeType(result.files.single.name);
        if (mimeType == null) {
          throw "File type unknown or unsupported";
        }
        final fileName = result.files.single.name;
        await _storeFileAndSend(result.files.single.bytes!, false, mimeType, fileName);
      } catch (e, s) {
        toast(e.toString());
        debugPrintStack(stackTrace: s);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final bytes = await result.readAsBytes();

      try {
        await _storeFileAndSend(bytes, true, result.mimeType!);
        _setAttachmentUploading(false);
      } catch (e, s) {
        toast(e.toString());
        debugPrintStack(stackTrace: s);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  Future<void> _storeFileAndSend(
      Uint8List bytes, bool isImage, String mimeType, [String? fileName]) async {
    debugPrint("Storing file with mime type $mimeType");
    final id = uuid.v4();
    final reference = FirebaseStorage.instance.ref(id);

    // Mime types supported by WhatsApp:
    // https://developers.facebook.com/docs/whatsapp/cloud-api/reference/media#supported-media-types
    if (isImage) {
      if (mimeType != "image/jpeg" && mimeType != "image/png") {
        throw "Unsupported image type";
      }
    } else {
      final supportedDocumentMimeTypes = [
        "text/plain",
        "application/pdf",
        "application/vnd.ms-powerpoint",
        "application/msword",
        "application/vnd.ms-excel",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      ];
      if (!supportedDocumentMimeTypes.contains(mimeType)) {
        throw "Unsupported document type";
      }
    }

    if (kIsWeb) {
      await reference.putData(bytes, SettableMetadata(contentType: mimeType));
    } else {
      throw "Not implemented";
      // final filePath = result.files.single.path!;
      // final file = File(filePath);
      // // final message = types.PartialFile(
      // //   mimeType: lookupMimeType(filePath),
      // //   name: name,
      // //   size: result.files.single.size,
      // //   // uri: uri,
      // // );

      // // final image = await decodeImageFromList(bytes);
      // // final message = types.PartialImage(
      // //   height: image.height.toDouble(),
      // //   name: name,
      // //   size: size,
      // //   uri: uri,
      // //   width: image.width.toDouble(),
      // // );

      // await reference.putFile(file);
    }
    final uri = await reference.getDownloadURL();

    debugPrint("send message: $uri");

    await Future.delayed(const Duration(seconds: 2));

    final msgRequest = SendMessageRequest(
      from: widget.botId,
      to: widget.user.id,
    );

    if (isImage) {
      msgRequest.imageUrl = uri;
    } else {
      msgRequest.documentUrl = uri;
      msgRequest.filename = fileName;
    }

    await (await BotServerApiClient.getClient()).sendMessage(
      msgRequest,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }
}
