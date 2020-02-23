import 'package:flutter/material.dart';

import 'package:minimal_impl/transition_animations/common/b.dart';

class FadeThroughScreen extends StatelessWidget {
  const FadeThroughScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ContentB('Fade through'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
