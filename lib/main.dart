import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/screens/profile_screen.dart';
import 'package:fluttertest/screens/video_list.dart';
import 'package:fluttertest/screens/video_screen.dart';
import 'package:fluttertest/screens/settings_screen.dart';
import 'package:fluttertest/screens/login.dart';
import 'package:fluttertest/screens/splash_screen.dart';
import 'package:fluttertest/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, child) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const Splash(),
            routes: {
              Login.routName: (ctx) => const Login(),
              VideoPage.routName: (ctx) => const VideoPage(),
              VideoList.routName: (ctx) => const VideoList(),
              SettingsScreen.routName: (ctx) => const SettingsScreen(),
              Profile.routName: (ctx) => const Profile(),
            },
          );
        },
      ),
    );
  }
}
