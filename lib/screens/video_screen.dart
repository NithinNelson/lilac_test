import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/Models/video_model.dart';
import 'package:fluttertest/Widgets/navDrawer.dart';
import 'package:fluttertest/screens/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import '../Widgets/custom_videoprogress.dart';
import '../utils/custom_paint.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  static const routName = '/videoPage';

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _isVideoTaped = false;
  int _currentIndex = 0;
  late VideoPlayerController _controller;
  var _isDownloading = false;
  var _isDownloaded = false;
  var _doneLoading = false;
  var _loader = false;
  var progressStr = "";
  var progressPer = 0.0;
  dynamic currentpath = '';
  var checkPermission;

  _controllerInitialize() {
    if (currentpath != '') {
      print('----gbrw--------$currentpath');
      File videoFile = File(currentpath);
      _controller = VideoPlayerController.file(videoFile)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((value) => _controller.play());
    } else {
      print("------here-----");
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          videos[_currentIndex].url,
        ),
      )
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((value) => _controller.play());
    }
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Future<File?> downloadFile(String url, String filename) async {
    print(url);
    //final appStorage = await getApplicationDocumentsDirectory();
    if (await Permission.storage.request().isGranted) {
      setState(() {
        _isDownloading = true;
      });
      //final path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      final path = (await getApplicationDocumentsDirectory()).path;
      var dir = await Directory('$path/Videos');

      var file = File('/');
      if (await dir.exists()) {
        file = File('${dir.path}/$filename');
      } else {
        var dir = await Directory('$path/Videos').create(recursive: true);
        file = File('${dir.path}/$filename');
      }
      try {
        Dio dio = Dio();
        dio.download(url, '${dir.path}/$filename',
            onReceiveProgress: (rec, total) {
          setState(() {
            progressPer = rec / total;
            progressStr = ((rec / total) * 100).toStringAsFixed(0);
          });
          if (progressStr == '100') {
            _isDownloading = false;
          }
        }).then((_) async {
          if (progressStr == '100') {
            //_isDownloaded = true;
            await checkExist().then((value) {
              setState(() {
                _doneLoading = true;
              });
            });
          }
        });
        if (_doneLoading) {
          setState(() {
            _isDownloading = false;
            _isDownloaded = true;
          });
        }
        return file;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future checkExist() async {
    var status = await Permission.storage.status;
    print(status.isGranted);
    checkPermission = status.isGranted;
    print(checkPermission);
    if (checkPermission == true) {
      final path = (await getApplicationDocumentsDirectory()).path;
      print('path-------->$path');
      var dir = await Directory('$path/Videos');
      try {
        var files = dir.listSync();
        print(files.length);
        files.forEach((file) {
          print('file path---------------->${file.path}');
          print('${videos[_currentIndex].name.split('/').last}-video.mp4');
          if ((file.path.split('/').last ==
              "${videos[_currentIndex].name.split('/').last}-video.mp4")) {
            setState(() {
              currentpath = file.path;
              _isDownloaded = true;
            });
            print("------gnr---------$currentpath");
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _initialize() async {
    setState(() {
      _loader = true;
    });
    await checkExist();
    _controllerInitialize();
    setState(() {
      _loader = false;
    });
  }

  @override
  void didChangeDependencies() {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    _currentIndex = arguments as int;
    _initialize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const Drawer(
        child: NavDrawer(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 230.h,
              // color: Colors.red,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isVideoTaped = !_isVideoTaped;
                        });
                      },
                      child: Container(
                        // height: 500,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _isVideoTaped = !_isVideoTaped),
                          child: Column(
                            children: [
                              Center(
                                child:
                                    _controller.value.isInitialized &&
                                            _loader == false
                                        ? Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              SizedBox(
                                                height: 200,
                                                child: VideoPlayer(
                                                  _controller,
                                                ),
                                              ),
                                              _isVideoTaped
                                                  ? Container(
                                                      height: 200,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  _key.currentState!
                                                                      .openDrawer();
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child:
                                                                      Container(
                                                                    width: 25.w,
                                                                    height:
                                                                        25.h,
                                                                    child:
                                                                        CustomPaint(
                                                                      painter:
                                                                          MenuIcon(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child:
                                                                    CircleAvatar(),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 20),
                                                            child: Row(
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _controller
                                                                              .value
                                                                              .isPlaying
                                                                          ? _controller
                                                                              .pause()
                                                                          : _controller
                                                                              .play();
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                    _controller
                                                                            .value
                                                                            .isPlaying
                                                                        ? Icons
                                                                            .pause
                                                                        : Icons
                                                                            .play_arrow,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 32,
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.85,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.02,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.65,
                                                                            child:
                                                                                CustomVideoProgressIndicator(
                                                                              controller: _controller,
                                                                            ),
                                                                          ),
                                                                          ValueListenableBuilder(
                                                                            valueListenable:
                                                                                _controller,
                                                                            builder: (context,
                                                                                VideoPlayerValue value,
                                                                                child) {
                                                                              return Text(
                                                                                _videoDuration(value.position),
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                          const Text(
                                                                            "/",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            _videoDuration(_controller.value.duration),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      // height: MediaQuery.of(context)
                                                                      //         .size
                                                                      //         .height *
                                                                      //     0.02,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.85,
                                                                      // color: Colors.red,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () => prev(),
                                                                                  icon: Icon(
                                                                                    Icons.skip_previous,
                                                                                    color: Colors.white,
                                                                                    size: 25,
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () => next(),
                                                                                  icon: Icon(
                                                                                    Icons.skip_next,
                                                                                    color: Colors.white,
                                                                                    size: 25,
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    if (_controller.value.volume == 0.0) {
                                                                                      _controller.setVolume(1.0);
                                                                                    } else {
                                                                                      _controller.setVolume(0.0);
                                                                                    }
                                                                                  },
                                                                                  icon: Icon(_controller.value.volume == 0.0 ? Icons.volume_off : Icons.volume_up),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () {},
                                                                                  icon: Icon(
                                                                                    Icons.settings,
                                                                                    color: Colors.white,
                                                                                    size: 25,
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {},
                                                                                  icon: Icon(
                                                                                    Icons.fullscreen,
                                                                                    color: Colors.white,
                                                                                    size: 25,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          )
                                        : Container(
                                            height: 200,
                                            color: Colors.black,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _isVideoTaped
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _key.currentState!.openDrawer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 25.w,
                                  height: 25.h,
                                  child: CustomPaint(
                                    painter: MenuIcon(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(Profile.routName),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).iconTheme.color),
                              ),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      prev();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _isDownloaded
                      ? InkWell(
                          onTap: () {
                            _controllerInitialize();
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).iconTheme.color,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: const Color(0xFF57EE9D),
                                  size: 40,
                                ),
                                Text(
                                  "Downloaded",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _isDownloading
                          ? Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).iconTheme.color,
                                  borderRadius: BorderRadius.circular(16)),
                              child: CircularPercentIndicator(
                                radius: 12,
                                lineWidth: 4.0,
                                percent: progressPer,
                                //fillColor: ColorUtil.white,
                                backgroundColor: Colors.black,
                                progressColor: Colors.blueAccent,
                                center: Text(
                                  progressStr,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 6.sp),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await downloadFile(videos[_currentIndex].url,
                                    '${videos[_currentIndex].name}-video.mp4');
                                _controllerInitialize();
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).iconTheme.color,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: const Color(0xFF57EE9D),
                                      size: 40,
                                    ),
                                    Text(
                                      "Download",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  GestureDetector(
                    onTap: () {
                      next();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).iconTheme.color,
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  next() async {
    if (_currentIndex < videos.length - 1) {
      setState(() {
        _currentIndex = _currentIndex + 1;
      });
    } else {
      setState(() {
        _currentIndex = 0;
      });
    }
    print("------tvb------$_currentIndex");
    print("------rt------${videos.length - 1}");
    setState(() {
      currentpath = '';
      _isDownloaded = false;
    });
    await checkExist();
    _controllerInitialize();
  }

  prev() async {
    if (_currentIndex > videos.length - 1) {
      setState(() {
        _currentIndex = _currentIndex - 1;
      });
    } else {
      setState(() {
        _currentIndex = videos.length - 1;
      });
    }
    print("------tvb------$_currentIndex");
    print("------rt------${videos.length - 1}");
    setState(() {
      currentpath = '';
      _isDownloaded = false;
    });
    await checkExist();
    _controllerInitialize();
  }
}
