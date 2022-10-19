import 'package:flutter/foundation.dart';
import 'package:oktoast/oktoast.dart';

void toast(String msg, {ToastPosition? position, Duration? duration}) {
  debugPrint("TOAST:$msg");
  showToast(msg, position: position, duration: duration ?? const Duration(seconds: 3));
}

