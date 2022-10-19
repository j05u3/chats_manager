import 'package:chats_manager/private_constants.dart';
import 'package:flutter/material.dart';
import 'package:chats_manager/models/users.dart' as types;

import '../firestore/messaging_backend.dart';
import '../utils/user_ui_util.dart';

class UsersWidget extends StatelessWidget {
  final Function(types.User, String) onUserSelected;
  final types.User? userSelected;
  final String? botIdSelected;

  const UsersWidget(
      {super.key,
      required this.onUserSelected,
      required this.userSelected,
      required this.botIdSelected});

  @override
  Widget build(BuildContext context) => StreamBuilder<List<types.User>>(
        stream: MessagingBackend.instance.users(),
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
                  onUserSelected(user, botId);
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
