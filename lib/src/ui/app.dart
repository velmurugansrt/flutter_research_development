import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_research_development/src/assets/theme/app_themes.dart';
import 'package:flutter_research_development/src/assets/theme/theme_bloc.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';
import 'package:flutter_research_development/src/ui/screen/init/int_screen.dart';

class APP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ThemeBloc(),
      child: AppRoutes(),
    );
  }
}

class AppRoutes extends StatelessWidget {
  const AppRoutes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        debugPrint('state $state');
        return MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          initialRoute: ScreenRoutes.INIT_SCREEN,
          theme: AppTheme.themeManager(state.themeType),
          onGenerateRoute: generateRoute,
        );
      },
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenRoutes.INIT_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.INIT_SCREEN),
        builder: (BuildContext context) {
          return InitScreen();
        },
      );
      break;
  }
}
