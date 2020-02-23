import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:minimal_impl/transition_animations/common/a.dart';
import 'package:minimal_impl/transition_animations/common/b.dart';
import 'package:minimal_impl/transition_animations/common/c.dart';

class FadeScaleWidgetScreen extends StatefulWidget {
  const FadeScaleWidgetScreen();

  @override
  _FadeScaleWidgetScreenState createState() => _FadeScaleWidgetScreenState();
}

class _FadeScaleWidgetScreenState extends State<FadeScaleWidgetScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _isShown = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1.0,
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade scale (widget)'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Expanded(child: ContentA()),
          Expanded(
            child: FadeScaleTransition(
              animation: _controller,
              child: const ContentB(),
            ),
          ),
          const Expanded(child: ContentC()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isShown ? Icons.remove : Icons.add),
        onPressed: () {
          _isShown ? _controller.reverse() : _controller.forward();
          setState(() {
            _isShown = !_isShown;
          });
        },
      ),
    );
  }
}
