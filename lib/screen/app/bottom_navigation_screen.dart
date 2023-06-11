import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:revew_ui_app/api/api_controller.dart';
import 'package:revew_ui_app/prefs/prefs_controller.dart';
import 'package:revew_ui_app/screen/app/categories_screen.dart';
import 'package:revew_ui_app/screen/app/home_screen.dart';
import 'package:revew_ui_app/screen/app/setting_ui_screen.dart';
import 'package:revew_ui_app/screen/app/user_screen.dart';
import 'package:revew_ui_app/screen/model/bn_sreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selected = 0;
  String email = SharedPrefController().getValue<String>(PrefKeys.email) ?? "";

  final List<BnItem> _bnItem = <BnItem>[
    const BnItem(title: "Home", widget: HomeScreen()),
    const BnItem(title: "Categories", widget: CategoriesScreen()),
    const BnItem(title: "user", widget: User()),
    const BnItem(title: "Setting", widget: SettingUiScrren()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(),
              accountName: Text("Mohamed Abed All"),
              accountEmail: Text(email),
            ),
            const ListTile(
              title: Text("Phone"),
              subtitle: Text("this phone is very coll "),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.phone_enabled),
            ),
            const Divider(
              color: Colors.black26,
            ),
            ListTile(
              title: const Text("logout"),
              subtitle: const Text("Return to login "),
              leading: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async{
                    bool result = await ApiController().logout();
                    if(result){
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacementNamed(context, '/login_screen');

                      });
                    }else{
                      print("filed");
                    }
       
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_bnItem[selected].title),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: ()=>Navigator.pushNamed(context, "/images_screen"), icon: Icon(Icons.image))
        ],
      ),
      body: _bnItem[selected].widget,
      bottomNavigationBar: Animate(
        effects: const [ScaleEffect(), FadeEffect()],
        child: BottomNavigationBar(
          backgroundColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.white70,
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedIconTheme: const IconThemeData(color: Colors.white),
          currentIndex: selected,
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: "Categories",
                activeIcon: Icon(Icons.category)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Categories",
                activeIcon: Icon(Icons.person)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "Setting",
                activeIcon: Icon(Icons.settings)),
          ],
        ),
      ).animate().fade(duration: 10.ms).effect(curve: Curves.bounceIn),
    );
  }
// void _message (){
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Home"),behavior: SnackBarBehavior.floating,backgroundColor: Colors.red,));
// }
}
