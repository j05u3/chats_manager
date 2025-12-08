import 'package:flutter/cupertino.dart';
import 'package:web/web.dart' as web;

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
    final navigator = web.window.navigator;
    final platform = _getPlatform(navigator);
    final userAgent = navigator.userAgent;
    for (var name in _iOS) {
      if (platform.contains(name) || userAgent.contains(name)) {
        matches = true;
      }
    }
    return matches;
  }

  static String _getPlatform(web.Navigator navigator) {
    // navigator.platform is deprecated, but still useful for detection
    // Using a try-catch in case it's not available
    try {
      return (navigator as dynamic).platform ?? "";
    } catch (_) {
      return "";
    }
  }

  static bool isAndroid() {
    final navigator = web.window.navigator;
    final platform = _getPlatform(navigator);
    return platform == "Android" || navigator.userAgent.contains("Android");
  }

  static bool isMobile() => isAndroid() || isIOS();
  static bool isDesktop() => !isMobile();
  static bool isMobilish(BuildContext context) =>
      (isMobile() || MediaQuery.of(context).size.width <= 766);
}
