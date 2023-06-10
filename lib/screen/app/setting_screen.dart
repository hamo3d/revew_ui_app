import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       ListView(
        physics: const BouncingScrollPhysics(),
        children:  [
          const SizedBox(
            height: 50,
          ),
          CircleAvatar(
            radius: 67.5,
            child: Image.asset('images/image_profile.png'),
          ),
          const SizedBox(
            height: 24,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'John Deo',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: const Color(0xff444657)),
            ),
          ),
          const SizedBox(
            height: 7.5,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              'johndeo@yourmail.com',
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: const Color(0xff87879D)),
            ),
          ),
          const SizedBox(
            height: 33.8,
          ),
          Container(
            width: double.minPositive,
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffDEE8F2),
              ),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: const [
                SizedBox(
                  height: 10,
                ),
                SettingWidget(iconData: Icons.home_outlined,text: 'Home'),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Color(0xffDEE8F2),
                  thickness: 1.5,
                  height: 40,
                ),
                SettingWidget(iconData: Icons.person_2_outlined,text: 'My Profile'),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Color(0xffDEE8F2),
                  thickness: 1.5,
                  height: 40,
                ),
                SettingWidget(iconData: Icons.event,text: 'Event'),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  color: Color(0xffDEE8F2),
                  thickness: 1.5,
                  height: 40,
                ),
                SettingWidget(iconData: Icons.logout,text: 'log out'),

              ],
            ),
          ),
        ],
      );

  }
}

