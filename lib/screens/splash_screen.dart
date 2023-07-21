import 'package:flutter/material.dart';
import 'package:fluttertest/screens/video_list.dart';
import 'package:fluttertest/screens/video_screen.dart';
import 'package:fluttertest/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    _navigateTo();
    super.initState();
  }

  _navigateTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('login');
    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(context, VideoList.routName, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, Login.routName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
