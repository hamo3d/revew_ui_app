import 'package:flutter/material.dart';
import 'package:revew_ui_app/prefs/prefs_controller.dart';
import 'package:revew_ui_app/screen/app/bottom_navigation_screen.dart';
import 'package:revew_ui_app/screen/app/categories_screen.dart';
import 'package:revew_ui_app/screen/app/home_screen.dart';
import 'package:revew_ui_app/screen/app/login_screen.dart';
import 'package:revew_ui_app/screen/app/on_bording.dart';
import 'package:revew_ui_app/screen/app/setting_ui_screen.dart';
import 'package:revew_ui_app/screen/app/user_screen.dart';
import 'package:revew_ui_app/screen/images/images_screen.dart';
import 'package:revew_ui_app/screen/images/upload_image.dart';
import 'package:revew_ui_app/screen/launch_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/home_screen': (context) => const HomeScreen(),
        '/user_screen': (context) => const User(),
        '/categories_screen': (context) => const CategoriesScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/nav_screen': (context) => const BottomNavigationScreen(),
        '/setting_screen': (context) => const SettingUiScrren(),
        '/onBoarding_screen': (context) => const OnBoarding(),
        "/images_screen" : (context) =>  ImagesScreen(),
        "/upload_screen" : (context) => const UploadImage(),
      },
    );
  }
}
