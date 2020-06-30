//light_theme.dart
import 'package:flutter/material.dart';

const Color APP_PRIMARY_COLOR = Color(0xFF3977DE);
const Color APP_PRIMARY_LIGHT_COLOR = Color(0xFFD7E4F9);
const Color APP_ACCENT_COLOR = Color(0xFFF8F8F8);
const Color APP_BACKGROUND_COLOR = Color(0xFFFFFFFF);
const Color APP_BAR_BACKGROUND_COLOR = Color(0xFFFFFFFF);
const Color APP_BORDER_COLOR = Color(0xFF707070);
const Color APP_TEXT_COLOR = Color(0xFF353F4A);
const Color APP_ACCENT_TEXT_COLOR = Color(0xFF717880);
const Color APP_LIGHT_ACCENT_TEXT_COLOR = Color(0xFF636573);
const Color LABEL_COLOR = Color(0xFFAEB2B7);
const Color APP_INPUT_FILL_COLOR = Color(0xFFF1F1F1);
const Color SNACKBAR_BACKGROUND_COLOR = Color(0xFFDEDEDE);
const Color APP_OVERLINE_COLOR = APP_ACCENT_TEXT_COLOR;
const Color BLACK_COLOR = Color(0xFF1C1E30);
const Color APP_FOCUS_INPUT_BORDER_COLOR = Color(0xFFEAEBEC);
const Color APP_ICON_COLOR = Color(0xFF353F4A);
const Color APP_ACCENT_ICON_COLOR = Color(0xFF717880);
const Color APP_ERROR_COLOR = Color(0xFFD83831);

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: APP_PRIMARY_COLOR,
    primaryColorLight: APP_PRIMARY_LIGHT_COLOR,
    accentColor: APP_ACCENT_COLOR,
    backgroundColor: APP_BACKGROUND_COLOR,
    scaffoldBackgroundColor: APP_BACKGROUND_COLOR,
  );
}
