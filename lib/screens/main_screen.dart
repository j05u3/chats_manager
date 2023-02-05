import 'package:chats_manager/auth/firebase_auth_providers.dart';
import 'package:chats_manager/auth/screens.dart';
import 'package:chats_manager/models/users.dart';
import 'package:chats_manager/utils/web_platform.dart';
import 'package:chats_manager/widgets/users_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
        ElevatedButton.icon(
          onPressed: () async {
            for (final provider in firebaseOauthProviders) {
              await provider.logOutProvider();
            }
            await auth.FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamed(ManagerSignInScreen.routeName);
          },
          label: const Text("Sign out"),
          icon: const Icon(Icons.logout),
        ),
        const Divider(),
        Expanded(
          child: UsersWidget(onUserSelected: onUserSelected),
        ),
      ],
    );

    final chat = _selectedUser == null
        ? Container()
        : ChatWidget(
            key: Key(
                (_selectedUser?.id ?? '') + (_selectedBotId?.toString() ?? '')),
            user: _selectedUser!,
            botId: _selectedBotId!,
          );

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _selectedUser = null;
          _selectedBotId = null;
        });
        return false;
      },
      child: Scaffold(
        body: isMobilish
            ? (_selectedUser != null ? chat : chatList)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: 360, child: chatList),
                  Expanded(
                    child: chat,
                  ),
                ],
              ),
      ),
    );
  }

  onUserSelected(user, botIdx) {
    setState(() {
      _selectedUser = user;
      _selectedBotId = botIdx;
    });
  }
}
