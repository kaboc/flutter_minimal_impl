import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:minimal_impl/transition_animations/common/a.dart';

class FadeScaleModalScreen extends StatelessWidget {
  const FadeScaleModalScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade scale (modal)'),
      ),
      body: SafeArea(
        child: Center(
          child: RaisedButton(
            child: const Text('Show'),
            onPressed: () {
              showModal<void>(
                context: context,
                configuration: FadeScaleTransitionConfiguration(),
                builder: (context) {
                  return const _Modal();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Modal extends StatelessWidget {
  const _Modal();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 76.0),
      child: Stack(
        children: <Widget>[
          const Card(
            child: ContentA('Modal'),
          ),
          Positioned(
            top: 6.0,
            right: -14.0,
            child: RawMaterialButton(
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
