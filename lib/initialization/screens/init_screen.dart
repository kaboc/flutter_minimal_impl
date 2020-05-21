import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen._();

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const InitScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
