import 'package:flutter/material.dart';

import 'package:minimal_impl/transition_animations/common/a.dart';

class FadeScreen extends StatelessWidget {
  const FadeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ContentA('Fade'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
