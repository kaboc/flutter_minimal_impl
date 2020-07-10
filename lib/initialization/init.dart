import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/db_helper.dart';
import 'package:minimal_impl/initialization/navigator.dart';
import 'package:minimal_impl/initialization/user.dart';

class AppInit {
  AppInit({@required Locator locator})
      : _navigator = locator<AppNavigator>(),
        _dbHelper = locator<DbHelper>(),
        _userModel = locator<UserModel>() {
    _userModel.addListener(_onAppStateChanged);
  }

  final AppNavigator _navigator;
  final DbHelper _dbHelper;
  final UserModel _userModel;

  UserData _prevUserData;

  void dispose() {
    _userModel.removeListener(_onAppStateChanged);
  }

  void _onAppStateChanged() {
    if (_userModel.isReady && _userModel.data != _prevUserData) {
      print('User state changed.');

      _userModel.data == UserData.none
          ? _navigator.pushAndRemoveUntilLogin()
          : _navigator.pushAndRemoveUntilHome();
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
