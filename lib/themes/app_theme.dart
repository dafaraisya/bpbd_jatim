import 'package:bpbd_jatim/themes/color_theme.dart';
import 'package:bpbd_jatim/themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: textTheme,
    colorScheme: colorScheme,
  );
}
