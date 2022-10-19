import 'package:chats_manager/private_constants.dart';
import 'package:flutter/material.dart';
import 'package:chats_manager/models/users.dart' as types;

import '../firestore/messaging_backend.dart';
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

          return ListView.builder(
            itemCount: snapshot.data!.length * bot_phone_number_ids.length,
            itemBuilder: (context, _idx) {
              final index = _idx ~/ bot_phone_number_ids.length;
              final botIdx = _idx % bot_phone_number_ids.length;
              final botId = bot_phone_number_ids.entries.toList()[botIdx].key;
              final user = snapshot.data![index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    userSelected = user;
                    botIdSelected = botId;
                  });
                  widget.onUserSelected(user, botId);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: user.id == userSelected?.id && botId == botIdSelected
                      ? const Color.fromARGB(120, 255, 126, 126)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      _buildAvatar(user),
                      Text(getUserName(user) +
                          " " +
                          (bot_phone_number_ids[botId] ?? "")),
                    ],
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
