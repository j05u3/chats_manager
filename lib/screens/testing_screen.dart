import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  static const routeName = '/testing';

  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              FirebaseAnalytics.instance.logEvent(name: "test_event");
            },
            child: Text("analytics send test event")),
      ],
    ));
  }
}
