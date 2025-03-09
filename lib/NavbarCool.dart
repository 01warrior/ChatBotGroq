import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NavBarStylé"),
      ),

      body: Center(child: Text("😎😎😎cool")),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20)
          ),
          child: GNav(
              rippleColor: Colors.white70, // tab button ripple color when pressed
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 900), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.white70, // unselected icon color
              activeColor: Colors.lightGreenAccent, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Colors.blue.withOpacity(0.5), // selected tab background color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                GButton(
                  icon:Icons.access_alarm_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.account_box_rounded,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]
          ),
        ),
      ),
    );
  }
}
