import 'package:flutter/material.dart';

class CCDAppSnackBar {
  static CCDAppSnackBar get instance => _instance;

  factory CCDAppSnackBar() => _instance;
  static final CCDAppSnackBar _instance =
  CCDAppSnackBar._internal();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  CCDAppSnackBar._internal();

  static void showInfo(
      String message, {
        SnackBarAction? action,
        Duration duration = const Duration(seconds: 4),
      }) {
    if (scaffoldMessengerKey.currentState?.mounted == true) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          duration: duration,
          content: Text(message),
          action: action ??
              const SnackBarAction(
                label: 'Dismiss',
                onPressed: CCDAppSnackBar.dismiss,
              ),
        ),
      );
    }
  }

  static void showError(String message, {SnackBarAction? action}) {
    if (scaffoldMessengerKey.currentState?.mounted == true) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(message),
          action: action ??
              const SnackBarAction(
                label: 'Dismiss',
                onPressed: CCDAppSnackBar.dismiss,
                textColor: Colors.white,
              ),
          duration: const Duration(seconds: 15),
        ),
      );
    }
  }

  // ignore: long-parameter-list
  static void showInAppNotification({
    String? title,
    String? body,
    SnackBarAction? action,
    TextStyle? titleTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    TextStyle? bodyTextStyle,
    Duration duration = const Duration(seconds: 12),
  }) {
    if (scaffoldMessengerKey.currentState?.mounted == true) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          duration: duration,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title,
                  style: titleTextStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              if (body != null)
                Text(
                  body,
                  style: bodyTextStyle,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          action: action ??
              const SnackBarAction(
                label: 'Dismiss',
                onPressed: CCDAppSnackBar.dismiss,
              ),
        ),
      );
    }
  }

  static void dismiss() {
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }
}
