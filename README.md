# chats_manager

Display and manage your [Whatsapp Cloud API](https://developers.facebook.com/docs/whatsapp/cloud-api/) chats.

## What works so far:

* Display the text messages stored on Firestore using [these functions](https://gist.github.com/j05u3/b3ad1d5d9106a918941587e03c1919b1) for bots built using [@josue.0/whatsapp-cloud-api](https://www.npmjs.com/package/@josue.0/whatsapp-cloud-api) (version 0.2.7-alpha-01)
* Only works on web for now (not mobile or other platforms).

## Roadmap:

* Add support for showing templates or other types of messages.
* Be able to send messages to a specific contact.
* Be able to pause the bot or stop it.
* Firebase authentication.

## Development and deployment setup:

1. Run `flutterfire configure` and `firebase init` to setup firebase for your project. You also need to follow the instructions for each of the firebase libraries used here (check the pubspec.yaml file).
2. Create and populate the file `lib/private_constants.dart`. You take a look at the example file `lib/private_constants.example.dart`.

## Deployment:

1. Setup hosting: the build folder for web is `build/web`.
2. Using CMD on windows you can run the following command (&& is used to run the next command only if the previous one was successful):

```
flutter build web --release && firebase deploy --only hosting && time /t
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
