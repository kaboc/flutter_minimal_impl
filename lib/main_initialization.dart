// https://www.youtube.com/watch?v=xBmIzrzwfdo
// This video helped me a lot.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/db_helper.dart';
import 'package:minimal_impl/initialization/home_screen.dart';
import 'package:minimal_impl/initialization/init_screen.dart';
import 'package:minimal_impl/initialization/login_screen.dart';
import 'package:minimal_impl/initialization/user.dart';

void main() {
/*
  // Another option is to call the initialising process before runApp().
  // In that case, using a splash screen may be necessary.
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().init();
*/

  // See https://flutter.dev/docs/testing/errors for info on error handling.
  //
  // This does not seem to be working (at least on debug mode).
  // https://github.com/flutter/flutter/issues/47447
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      SystemNavigator.pop();
    }
  };

  runApp(
    MultiProvider(
      providers: [
        Provider<DbHelper>(
          create: (_) => DbHelper(),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigationKey = GlobalKey<NavigatorState>();
  UserData _prevUserData;

  @override
  void initState() {
    super.initState();

    Provider.of<UserModel>(context, listen: false)
        .addListener(_onAppStateChanged);
    _init();
  }

  @override
  void dispose() {
    Provider.of<UserModel>(context, listen: false)
        .removeListener(_onAppStateChanged);
    super.dispose();
  }

  void _onAppStateChanged() {
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (userModel.isReady && userModel.data != _prevUserData) {
      print('User state changed.');

      userModel.data == UserData.none
          ? _navigationKey.currentState
              .pushAndRemoveUntil<void>(LoginScreen.route(), (_) => false)
          : _navigationKey.currentState
              .pushAndRemoveUntil<void>(HomeScreen.route(), (_) => false);
      _prevUserData = userModel.data;
    }
  }

  Future<void> _init() async {
    print('Initialization started.');

    final dbHelper = Provider.of<DbHelper>(context, listen: false);
    await dbHelper.init();

    final userModel = Provider.of<UserModel>(context, listen: false);
    await userModel.init(dbHelper);

    print('Initialization finished.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initialization example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navigationKey,
      onGenerateRoute: (settings) => InitScreen.route(),
    );
  }
}
