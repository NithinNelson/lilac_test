import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertest/Models/video_model.dart';
import 'package:fluttertest/Widgets/navDrawer.dart';
import 'package:fluttertest/screens/video_screen.dart';
import 'package:video_player/video_player.dart';

import '../utils/custom_paint.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});
  static const routName = '/videoList';

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video Player",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  child: CustomPaint(
                    painter: MenuIcon(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: NavDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(VideoPage.routName, arguments: index);
                          },
                          title: Text(
                            videos[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              videos[index].thumbnail,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  );
                  // return Row(
                  //   children: [
                  //     SizedBox(
                  //       height: 100,
                  //       width: 100,
                  //       child: Image.network(
                  //         videos[index].thumbnail,
                  //         fit: BoxFit.contain,
                  //       ),
                  //     ),
                  //     Text(
                  //       videos[index].name,
                  //       style: const TextStyle(
                  //         fontSize: 25,
                  //       ),
                  //     ),
                  //   ],
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
