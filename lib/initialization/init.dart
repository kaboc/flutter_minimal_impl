import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/db_helper.dart';
import 'package:minimal_impl/initialization/screens/home_screen.dart';
import 'package:minimal_impl/initialization/screens/login_screen.dart';
import 'package:minimal_impl/initialization/user.dart';

class AppInit {
  AppInit({@required Locator locator})
      : _dbHelper = locator<DbHelper>(),
        _userModel = locator<UserModel>() {
    _userModel.addListener(_onAppStateChanged);
    init();
  }

  final DbHelper _dbHelper;
  final UserModel _userModel;

  final _navigatorKey = const GlobalObjectKey<NavigatorState>('navigator_key');
  UserData _prevUserData;

  void dispose() {
    _userModel.removeListener(_onAppStateChanged);
  }

  void _onAppStateChanged() {
    if (_userModel.isReady && _userModel.data != _prevUserData) {
      print('User state changed.');

      _userModel.data == UserData.none
          ? _navigatorKey.currentState
              .pushAndRemoveUntil<void>(LoginScreen.route(), (_) => false)
          : _navigatorKey.currentState
              .pushAndRemoveUntil<void>(HomeScreen.route(), (_) => false);
      _prevUserData = _userModel.data;
    }
  }

  Future<void> init() async {
    print('Initialization started.');

    await _dbHelper.init();
    await _userModel.init(_dbHelper);

    print('Initialization finished.');
  }
}
