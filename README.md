# chats_manager

Only works on web for now (not mobile or other platforms).

## Notes:

- Don't forget to run `flutterfire configure` and `firebase init` to setup firebase for your project. You also need to follow the instructions for each of the firebase libreries used here (check the pubspec.yaml file).
- Setup hosting: build folder for web is `build/web`.

## Deployment:

Using CMD on windows you can run the following command (&& is used to run the next command only if the previous one was successful):

```
flutter build web --release && firebase deploy --only hosting && time /t
```

## Acknowledgements

- https://javiercbk.github.io/json_to_dart/: For generating the models from json.
- https://github.com/flyerhq/flutter_chat_ui: For the chat UI and some examples used in here.
- https://github.com/flyerhq/flutter_firebase_chat_core: For some code snippets and ideas.

