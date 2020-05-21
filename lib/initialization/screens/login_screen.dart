import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:minimal_impl/initialization/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen._();

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LoginScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingNotifier = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: loadingNotifier,
            builder: (context, isPressed, _) {
              return isPressed
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('No exception'),
                        RaisedButton(
                          child: const Text('Log in'),
                          onPressed: () {
                            loadingNotifier.value = true;
                            context.read<UserModel>().login();
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Exception (catch, with await)'),
                        RaisedButton(
                          child: const Text('Log in'),
                          onPressed: () async {
                            loadingNotifier.value = true;

                            try {
                              await context
                                  .read<UserModel>()
                                  .login(successful: false);
                            } catch (e) {
                              loadingNotifier.value = false;
                              _showError(context);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Exception (catch, without await)'),
                        RaisedButton(
                          child: const Text('Log in'),
                          onPressed: () {
                            _showIndicatorAndError(context, loadingNotifier);

                            try {
                              context
                                  .read<UserModel>()
                                  .login(successful: false);
                            } catch (e) {
                              // Exception is not caught if the method in which
                              // the exception occurs is called without await,
                              // meaning this catch block is meaningless.
                              // RunZonedGuard's onError handler is called instead.
                              _showError(context);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Exception (no catch, with await)'),
                        RaisedButton(
                          child: const Text('Log in'),
                          onPressed: () async {
                            _showIndicatorAndError(context, loadingNotifier);

                            // Exception is caught by RunZonedGuard.
                            await context
                                .read<UserModel>()
                                .login(successful: false);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Exception (no catch, without await)'),
                        RaisedButton(
                          child: const Text('Log in'),
                          onPressed: () {
                            _showIndicatorAndError(context, loadingNotifier);

                            // Exception is caught by RunZonedGuard.
                            context
                                .read<UserModel>()
                                .login(successful: false);
                          },
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login failed.\nSee the console output.'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showIndicatorAndError(
    BuildContext context,
    ValueNotifier<bool> loadingNotifier,
  ) {
    loadingNotifier.value = true;
    Future<void>.delayed(
      const Duration(seconds: 2),
      () {
        loadingNotifier.value = false;
        _showError(context);
      },
    );
  }
}
