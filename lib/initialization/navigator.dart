import 'package:flutter/widgets.dart';

import 'package:minimal_impl/initialization/screens/home_screen.dart';
import 'package:minimal_impl/initialization/screens/login_screen.dart';

class AppNavigator {
  final navigatorKey = GlobalKey<NavigatorState>();

  void pushAndRemoveUntilLogin() {
    navigatorKey.currentState.pushAndRemoveUntil<void>(
      LoginScreen.route(),
      (_) => false,
    );
  }

  void pushAndRemoveUntilHome() {
    navigatorKey.currentState.pushAndRemoveUntil<void>(
      HomeScreen.route(),
      (_) => false,
    );
  }
}
