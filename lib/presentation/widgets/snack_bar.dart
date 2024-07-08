import 'package:flutter/material.dart';

void snackBarFunction({
  required BuildContext context,
  required String title,
  required String subtitle,
  Duration? animationDuration,
  double? borderRadius,
  Color? backgroundColor,
  Duration? duration,
  Curve? reverseAnimationCurve,
  DismissDirection? dismissDirection,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(subtitle),
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: backgroundColor,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
