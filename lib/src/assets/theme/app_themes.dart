
import 'package:flutter/material.dart';
import 'package:flutter_research_development/src/assets/theme/dark_Theme.dart';
import 'package:flutter_research_development/src/assets/theme/light_theme.dart';

class AppTheme {
  static const String DARK_MODE = 'Dark Mode';
  static const String LIGHT_MODE = 'Light Mode';

  static ThemeData themeManager(String themeType) {
    switch (themeType) {
      case DARK_MODE:
        return darkTheme();
        break;
      case LIGHT_MODE:
        return lightTheme();
        break;
      default:
        return lightTheme();
        break;
    }
  }
}
