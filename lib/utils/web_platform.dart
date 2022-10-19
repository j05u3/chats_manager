// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';

// credits to: https://medium.com/flutter-community/more-than-a-flutter-web-app-is-a-full-flutter-website-c6bb210b1f16

class WebPlatform {
  static final _iOS = [
    'iPad Simulator',
    'iPhone Simulator',
    'iPod Simulator',
    'iPad',
    'iPhone',
    'iPod'
  ];

  static bool isIOS() {
    var matches = false;
    for (var name in _iOS) {
      if ((html.window.navigator.platform ?? "").contains(name) ||
          html.window.navigator.userAgent.contains(name)) {
        matches = true;
      }
    }
    return matches;
  }

  static bool isAndroid() =>
      html.window.navigator.platform == "Android" ||
      html.window.navigator.userAgent.contains("Android");

  static bool isMobile() => isAndroid() || isIOS();
  static bool isDesktop() => !isMobile();
  static bool isMobilish(BuildContext context) =>
      (isMobile() || MediaQuery.of(context).size.width <= 766);
}
