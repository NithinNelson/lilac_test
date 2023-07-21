import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import '../Widgets/change_theme_button.dart';
import '../Widgets/navDrawer.dart';
import '../utils/custom_paint.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routName = '/settingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final IconData icon = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode;
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? "Dark Mode" : "Light Mode";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(text),
                            SizedBox(width: 10),
                            Icon(icon, color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                      ChangeThemeButton(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
