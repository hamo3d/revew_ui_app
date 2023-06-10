import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    required this.text,
    required this.iconData,
  });

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,
          color: const Color(0xff707070),
        ),
        const SizedBox(
          width: 27,
        ),
        Text(
          text,
          style: const TextStyle(color: Color(0xff87879D), fontSize: 19),
        ),
      ],
    );
  }
}
