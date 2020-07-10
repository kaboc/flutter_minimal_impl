import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:minimal_impl/transition_animations/container/container.dart';
import 'package:minimal_impl/transition_animations/fade_scale_modal/fade_scale_modal.dart';
import 'package:minimal_impl/transition_animations/fade_scale_widget/fade_scale_widget.dart';
import 'package:minimal_impl/transition_animations/fade_through/fade_through.dart';
import 'package:minimal_impl/transition_animations/shared_axis/shared_axis.dart';

void main() => runApp(const TransitionAnimations());

class TransitionAnimations extends StatelessWidget {
  const TransitionAnimations();

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Transition animations';

    timeDilation = 3.0;

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 18.0),
          button: TextStyle(fontSize: 16.0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _NavigationButton(
                    'Container',
                    builder: (_) => const ContainerScreen(),
                  ),
                  _NavigationButton(
                    'Shared axis',
                    builder: (_) => const SharedAxisScreen(),
                  ),
                  _NavigationButton(
                    'Fade through',
                    builder: (_) => const FadeThroughScreen(),
                  ),
                  _NavigationButton(
                    'Fade scale (modal)',
                    builder: (_) => const FadeScaleModalScreen(),
                  ),
                  _NavigationButton(
                    'Fade scale (widget)',
                    builder: (_) => const FadeScaleWidgetScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton(this.label, {@required this.builder});

  final String label;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RaisedButton(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(label),
        onPressed: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute(builder: builder),
          );
        },
      ),
    );
  }
}
