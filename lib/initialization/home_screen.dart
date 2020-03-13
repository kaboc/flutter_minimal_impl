import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hi, ${userModel.data.name}!'),
              RaisedButton(
                child: const Text('Log out'),
                onPressed: () => userModel.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
