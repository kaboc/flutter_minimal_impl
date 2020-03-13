import 'package:flutter/foundation.dart';

import 'package:minimal_impl/initialization/db_helper.dart';

class User {
  User(this.userId, this.name);

  final String userId;
  String name;
}

class UserData {
  UserData(User source)
      : id = source.userId,
        name = source.name;

  const UserData._()
      : id = null,
        name = null;

  final String id;
  final String name;

  static const none = UserData._();
}

class UserModel with ChangeNotifier {
  UserModel();

  DbHelper _dbHelper;
  UserData _userData;

  bool get isReady => _dbHelper != null;
  UserData get data => _userData ?? UserData.none;

  Future<void> init(DbHelper dbHelper) async {
    _dbHelper = dbHelper;
    notifyListeners();
  }

  Future<void> login() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final user = User('1', 'John');
    _userData = UserData(user);
    notifyListeners();
  }

  Future<void> logout() async {
    _userData = null;
    notifyListeners();
  }
}
