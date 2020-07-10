// https://www.youtube.com/watch?v=xBmIzrzwfdo
// This video helped me a lot.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/db_helper.dart';
import 'package:minimal_impl/initialization/init.dart';
import 'package:minimal_impl/initialization/navigator.dart';
import 'package:minimal_impl/initialization/screens/init_screen.dart';
import 'package:minimal_impl/initialization/user.dart';

void main() {
/*
  // Another option is to call the initialising process before runApp().
  // In that case, having the splash screen may be preferable.
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().init();
*/

  // Errors that occur during callbacks triggered by the framework itself is
  // routed to the FlutterError.onError handler.
  // See https://flutter.dev/docs/testing/errors for info on error handling.
  //
  // This does not seem to be working (at least on debug mode).
  // https://github.com/flutter/flutter/issues/47447
  FlutterError.onError = (details) {
    print('FlutterError.onError');
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      SystemNavigator.pop();
    }
  };

  runZonedGuarded<Future<void>>(
    () async => runApp(
      MultiProvider(
        providers: [
          Provider<AppNavigator>(
            create: (_) => AppNavigator(),
          ),
          Provider<DbHelper>(
            create: (_) => DbHelper(),
          ),
          ChangeNotifierProvider<UserModel>(
            create: (_) => UserModel(),
          ),
          Provider<AppInit>(
            lazy: false,
            create: (context) => AppInit(locator: context.read)..init(),
            dispose: (_, init) => init.dispose(),
          ),
        ],
        child: const App(),
      ),
    ),
    (Object e, StackTrace _) {
      print('runZonedGuarded.onError');
      print(e);
    },
  );
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: context.watch<AppNavigator>().navigatorKey,
      onGenerateRoute: (settings) => InitScreen.route(),
    );
  }
}
