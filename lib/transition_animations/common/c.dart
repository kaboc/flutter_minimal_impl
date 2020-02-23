import 'package:flutter/material.dart';

class ContentC extends StatelessWidget {
  const ContentC([this.text = '']);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.brown.shade300,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
