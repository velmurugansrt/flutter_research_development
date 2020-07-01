import 'package:flutter/material.dart';

class AppImages {
  static DecorationImage loginBackground({double width, double height}) {
    return const DecorationImage(
      image: AssetImage('lib/src/assets/images/login_background.jpg'),
      fit: BoxFit.cover,
    );
  }
}
