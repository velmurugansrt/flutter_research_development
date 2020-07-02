import 'package:flutter/material.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';

class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    heartbeatAnimation =
        Tween<double>(begin: 100.0, end: 150.0).animate(controller);
    controller.forward().whenComplete(() {
      controller.reverse();
      Navigator.of(context).pushReplacementNamed(ScreenRoutes.LOGIN_SCREEN);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: heartbeatAnimation,
      builder: (BuildContext context, Widget widget) {
        return Scaffold(
          body: Center(
            child: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
              size: heartbeatAnimation.value,
            ),
          ),
        );
      },
    );
  }
}
