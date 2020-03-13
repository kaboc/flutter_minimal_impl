import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pressNotifier = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: pressNotifier,
            builder: (context, isPressed, _) {
              return isPressed
                  ? const CircularProgressIndicator()
                  : RaisedButton(
                      child: const Text('Log in'),
                      onPressed: () {
                        Provider.of<UserModel>(context, listen: false).login();
                        pressNotifier.value = true;
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
