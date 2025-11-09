import 'package:flutter/material.dart';

@immutable
class AppStyle {
  static TextStyle? listTitleStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle? listSubtitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge;
  }
}
