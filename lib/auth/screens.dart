import 'package:chats_manager/screens/main_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/widgets.dart';

class ManagerSignInScreen extends SignInScreen {
  static const routeName = '/sign-in';

  ManagerSignInScreen({super.key})
      : super(
          showAuthActionSwitch: false,
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              FirebaseAnalytics.instance.setUserId(id: state.user?.uid ?? "");
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            }),
          ],
        );
}
