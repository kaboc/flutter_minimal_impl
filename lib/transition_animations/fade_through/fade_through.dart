import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:minimal_impl/transition_animations/common/a.dart';
import 'package:minimal_impl/transition_animations/common/b.dart';
import 'package:minimal_impl/transition_animations/common/c.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen();

  @override
  _FadeThroughScreenState createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Fade through'),
            bottom: TabBar(
              tabs: const <Widget>[
                Tab(text: 'Red'),
                Tab(text: 'Orange'),
                Tab(text: 'Brown'),
              ],
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              child: PageTransitionSwitcher(
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return FadeThroughTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                  );
                },
                child: const <Widget>[
                  ContentA('Red'),
                  ContentB('Orange'),
                  ContentC('Brown'),
                ][_pageIndex],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
