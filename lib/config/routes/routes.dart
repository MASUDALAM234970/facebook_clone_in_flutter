import 'package:facebook_clone_in_flutter/core/screens/error_screen.dart';
import '../../core/screens/home_screen.dart';
import '../../features/auth/presentation/screens/create_account_screee.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateAccountScreen.routeName:
        return _cupertinoRoute(const CreateAccountScreen());
      case HomeScreen.routeName:
        return _cupertinoRoute(
          const HomeScreen(),
        );
      default:
        return _cupertinoRoute(
          ErrorScreen(error: 'Wrong Route provided ${settings.name}'),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
