import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_research_development/src/assets/theme/app_themes.dart';
import 'package:flutter_research_development/src/assets/theme/theme_bloc.dart';
import 'package:flutter_research_development/src/blocs/home/home_bloc.dart';
import 'package:flutter_research_development/src/blocs/login/login_bloc.dart';
import 'package:flutter_research_development/src/ui/navigation/screen_routes.dart';
import 'package:flutter_research_development/src/ui/screen/home/home_screen.dart';
import 'package:flutter_research_development/src/ui/screen/init/int_screen.dart';
import 'package:flutter_research_development/src/ui/screen/login/login_screen.dart';
import 'package:flutter_research_development/src/ui/screen/order_status/order_status_screen.dart';

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
        return MaterialApp(
          builder: (BuildContext context, Widget child) {
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

// ignore: missing_return
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
    case ScreenRoutes.LOGIN_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.LOGIN_SCREEN),
        builder: (BuildContext context) {
          return BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
            child: LoginScreen(),
          );
        },
      );
      break;
    case ScreenRoutes.HOME_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.HOME_SCREEN),
        builder: (BuildContext context) {
          return BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
            child: HomeScreen(),
          );
        },
      );
      break;
    case ScreenRoutes.ORDER_STATUS_SCREEN:
      return MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: ScreenRoutes.ORDER_STATUS_SCREEN),
        builder: (BuildContext context) {
          return OrderStatusScreen();
        },
      );
      break;
  }
}
