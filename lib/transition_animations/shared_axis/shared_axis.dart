import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:minimal_impl/transition_animations/common/a.dart';
import 'package:minimal_impl/transition_animations/common/b.dart';
import 'package:minimal_impl/transition_animations/common/c.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen();

  @override
  _SharedAxisScreenState createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _prev = 1;
  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared axis'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Card(
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverse: _current < _prev,
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return SharedAxisTransition(
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                      );
                    },
                    child: const <Widget>[
                      ContentA('1'),
                      ContentB('2'),
                      ContentC('3'),
                    ][_current - 1],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _button(1),
                  _button(2),
                  _button(3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(int number) {
    return SizedBox(
      height: 60.0,
      child: RaisedButton(
        child: Text(number.toString()),
        shape: const CircleBorder(),
        color: number == _current ? Colors.grey.shade400 : Colors.grey.shade200,
        elevation: number == _current ? 0.0 : null,
        onPressed: () {
          setState(() {
            _prev = _current;
            _current = number;
          });
        },
      ),
    );
  }
}
