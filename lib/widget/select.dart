import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnBording extends StatelessWidget {
  OnBording({
    required this.color,
    super.key,
  });

  late Color color;

  @override
  Widget build(BuildContext context) {
    return TabPageSelectorIndicator(
        backgroundColor: color, borderColor: Colors.blue, size: 10);
  }
}
