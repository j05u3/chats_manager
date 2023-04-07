import 'package:chats_manager/private_constants.dart';
import 'package:flutter/material.dart';
import 'package:chats_manager/models/users.dart' as types;
import 'package:flutter/services.dart';

import '../firestore/messaging_backend.dart';
import '../utils/toast_util.dart';
import '../utils/user_ui_util.dart';

class UsersWidget extends StatefulWidget {
  final Function(types.User, String) onUserSelected;

  const UsersWidget({super.key, required this.onUserSelected});

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  types.User? userSelected;
  String? botIdSelected;

  final Stream<List<types.User>> _stream =
      MessagingBackend.instance.users().asBroadcastStream();

  @override
  Widget build(BuildContext context) => StreamBuilder<List<types.User>>(
        stream: _stream,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: const Text('No users'),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length * bot_phone_number_ids.length,
            itemBuilder: (context, _idx) {
              final index = _idx ~/ bot_phone_number_ids.length;
              final botIdx = _idx % bot_phone_number_ids.length;
              final botId = bot_phone_number_ids.entries.toList()[botIdx].key;
              final user = users[index];

              copyPhoneNumber() {
                Clipboard.setData(ClipboardData(text: user.id));
                toast("User phone number copied to clipboard ✌️");
              }

              return GestureDetector(
                onTap: () {
                  setState(() {
                    userSelected = user;
                    botIdSelected = botId;
                  });
                  widget.onUserSelected(user, botId);
                },
                onLongPress: copyPhoneNumber,
                onSecondaryTap: copyPhoneNumber,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: user.id == userSelected?.id && botId == botIdSelected
                      ? const Color.fromARGB(120, 255, 126, 126)
                      : Colors.transparent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildAvatar(user),
                        Text(
                            "[${(bot_phone_number_ids[botId] ?? "")}] ${getUserName(user)}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: color,
        backgroundImage: null,
        radius: 20,
        child: Text(
          name.isEmpty ? '' : name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
