import 'package:chats_manager/models/users.dart';
import 'package:chats_manager/utils/web_platform.dart';
import 'package:chats_manager/widgets/users_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_widget.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? _selectedUser;
  String? _selectedBotId;

  @override
  Widget build(BuildContext context) {
    final isMobilish = WebPlatform.isMobilish(context);

    final chatList = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: UsersWidget(
              key: Key(_selectedUser?.id ?? ""),
              userSelected: _selectedUser,
              botIdSelected: _selectedBotId,
              onUserSelected: (user, botIdx) {
                setState(() {
                  _selectedUser = user;
                  _selectedBotId = botIdx;
                });
              }),
        ),
      ],
    );

    final chat = _selectedUser == null
        ? Container()
        : ChatWidget(
            key: Key((_selectedUser?.id ?? '') + (_selectedBotId?.toString() ?? '')),
            user: _selectedUser!,
            botId: _selectedBotId!,
          );

    return Scaffold(
      body: isMobilish
          ? chatList
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 360, child: chatList),
                Expanded(
                  child: chat,
                ),
              ],
            ),
    );
  }
}
