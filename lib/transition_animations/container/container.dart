import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:minimal_impl/transition_animations/container/fade.dart';
import 'package:minimal_impl/transition_animations/container/fade_through.dart';

class ContainerScreen extends StatelessWidget {
  const ContainerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _Button(
                label: 'Fade',
                color: Colors.red.shade200,
                transitionType: ContainerTransitionType.fade,
                openBuilder: (_, __) => const FadeScreen(),
              ),
              const SizedBox(height: 32.0),
              _Button(
                label: 'Fade through',
                color: Colors.orange.shade200,
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (_, __) => const FadeThroughScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    @required this.label,
    @required this.color,
    @required this.transitionType,
    @required this.openBuilder,
  });

  final String label;
  final Color color;
  final ContainerTransitionType transitionType;
  final OpenContainerBuilder openBuilder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OpenContainer(
        transitionType: transitionType,
        openBuilder: openBuilder,
        closedBuilder: (_, openCallback) {
          return FlatButton(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 130.0,
                    color: color,
                    margin: EdgeInsets.zero,
                  ),
                ),
                Text(label),
              ],
            ),
            onPressed: openCallback,
          );
        },
        tappable: false,
      ),
    );
  }
}
