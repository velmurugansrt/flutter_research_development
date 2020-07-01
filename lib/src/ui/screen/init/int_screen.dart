import 'package:flutter/material.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';

class InitScreen extends StatefulWidget {
  InitScreen({Key key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.of(context).pushNamed(ScreenRoutes.HOME_SCREEN);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Init Screen'),
        ),
      ),
    );
  }
}
