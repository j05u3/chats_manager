import 'package:chats_manager/util/web_platform.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobilish = WebPlatform.isMobilish(context);

    final chatList = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(color: Colors.amber),
        ),
      ],
    );

    return Scaffold(
      body: isMobilish
          ? chatList
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 380, child: chatList),
                Expanded(
                  child: Container(color: Colors.blue),
                ),
              ],
            ),
    );
  }
}
