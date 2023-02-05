import 'package:chats_manager/private_constants.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

final firebaseOauthProviders = [
  GoogleProvider(clientId: GOOGLE_SIGN_IN_OAUTH_CLIENT_ID),
];
