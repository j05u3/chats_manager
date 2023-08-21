# chats_manager

Display and manage your [Whatsapp Cloud API](https://developers.facebook.com/docs/whatsapp/cloud-api/) chats.

## What works so far:

* Display the text messages stored on Firestore using [these functions](https://gist.github.com/j05u3/b3ad1d5d9106a918941587e03c1919b1) for bots built using [whatsapp-cloud-api-express](https://github.com/j05u3/whatsapp-cloud-api-express) or [@josue.0/whatsapp-cloud-api](https://www.npmjs.com/package/@josue.0/whatsapp-cloud-api) (version 0.2.7-alpha-04)
* Display the message statuses.
* Firebase authentication with Google.
* Basic templates display support through the `private_constants.dart` file.
* Only works on web for now (not mobile or other platforms).

## Roadmap:

* Be able to send messages to a new phone number.
* Be able to pause the bot or stop it.

## Development and deployment setup:

1. Run `flutterfire configure` and `firebase init` to setup firebase for your project. Choose `build/web` as the public folder. You also need to follow the instructions for each of the firebase libraries used here (check the pubspec.yaml file). Some of those are:
  - https://github.com/firebase/flutterfire/blob/master/packages/firebase_ui_auth/doc/providers/oauth.md
  
2. Create and populate the file `lib/private_constants.dart`. You take a look at the example file `lib/private_constants_example.dart`.

## Deployment:

1. Setup hosting: the build folder for web is `build/web`.
2. Using CMD on windows you can run the following command (&& is used to run the next command only if the previous one was successful):

```
flutter build web --release && firebase deploy --only hosting && time /t

# or if using targets:
flutter build web --release && firebase deploy --only hosting:TARGET_NAME
```

## Notes:

- When changing or using @JsonSerializable (to generate models) run `flutter pub run build_runner build` or `flutter pub run build_runner watch --delete-conflicting-outputs` to start the watcher.
- If your are hosting your images on Google Storage don't forget to add the CORS configuration to allow the images to be displayed on the web. Example cors json config:

```json
[
  {
    "origin": ["*"],
    "method": ["GET", "POST", "PUT", "DELETE"],
    "responseHeader": ["Content-Type"],
    "maxAgeSeconds": 3600
  }
]
```

## Acknowledgements

- https://github.com/flyerhq/flutter_chat_ui: For the chat UI and other UI component ideas used in here.
- https://github.com/flyerhq/flutter_firebase_chat_core: For some code snippets and ideas.
- https://github.com/tawn33y/whatsapp-cloud-api: For the original Whatsapp Cloud API bot library.
- https://javiercbk.github.io/json_to_dart/: Used for generating the initial models from json.
