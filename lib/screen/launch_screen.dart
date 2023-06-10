import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revew_ui_app/prefs/prefs_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      String route =
          SharedPrefController().getValue<bool>(PrefKeys.loggedIn) ?? false
              ? "/nav_screen"
              : '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              Color(0xffE3F2C1),
              Color(0xffC9DBB2),
            ],
          ),
        ),
        child: Animate(
          // ignore: prefer_const_literals_to_create_immutables
          effects: [const FadeEffect(), const ScaleEffect()],
          child: const Text(
            'Ui App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
              .animate()
              .fade(duration: 500.ms)
              .scale(delay: 500.ms)
              .slide(curve: Curves.easeIn),
        ),
      ),
    );
  }
}
