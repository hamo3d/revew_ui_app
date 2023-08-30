import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({
    required this.title,
    super.key,
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            maxRadius: 45,
            backgroundImage: NetworkImage(
                'https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
