import 'package:flutter/material.dart';
import 'package:fluttertest/screens/login.dart';
import 'package:fluttertest/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/profile_screen.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView(
            children: [
              ListTile(
                title: Text("Profile"),
                leading: Icon(Icons.account_circle_rounded, color: Theme.of(context).primaryColor,),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
                onTap: () => Navigator.of(context).pushNamed(Profile.routName),
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings, color: Theme.of(context).primaryColor),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
                onTap: () => Navigator.of(context).pushNamed(SettingsScreen.routName),
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout_outlined, color: Theme.of(context).primaryColor),
                trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor),
                onTap: () {
                  _logout();
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("login");
    Navigator.of(context).pushNamedAndRemoveUntil(Login.routName, (route) => false);
  }
}
