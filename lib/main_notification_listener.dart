import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('NotificationListener')),
        body: SafeArea(
          child: NotificationListenerBuilder<ScrollNotification>(
            cancel: true,
            builder: (scroll, child) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    color: Colors.lightBlue.shade100,
                    child: Text((scroll?.metrics?.pixels ?? 0).toString()),
                  ),
                  child,
                ],
              );
            },
            child: Expanded(
              child: Builder(
                builder: (context) => ListView.builder(
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationListenerBuilder<T extends Notification>
    extends StatefulWidget {
  const NotificationListenerBuilder({
    @required this.builder,
    this.child,
    this.cancel = false,
  });

  final Widget Function(T, Widget) builder;
  final Widget child;
  /// Whether to cancel the notification bubbling
  final bool cancel;

  @override
  _NotificationListenerBuilderState createState() =>
      _NotificationListenerBuilderState<T>(builder);
}

class _NotificationListenerBuilderState<T extends Notification>
    extends State<NotificationListenerBuilder> {
  _NotificationListenerBuilderState(this.builder);

  Widget Function(T, Widget) builder;
  T _notification;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<T>(
      onNotification: (T notification) {
        setState(() => _notification = notification);
        return widget.cancel;
      },
      child: builder(_notification, widget.child),
    );
  }
}
