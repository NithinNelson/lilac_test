import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/custom_thubIcon.dart';

class CustomVideoProgressIndicator extends StatefulWidget {
  final VideoPlayerController controller;

  const CustomVideoProgressIndicator({super.key, required this.controller});

  @override
  _CustomVideoProgressIndicatorState createState() =>
      _CustomVideoProgressIndicatorState();
}

class _CustomVideoProgressIndicatorState
    extends State<CustomVideoProgressIndicator> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (widget.controller.value.isInitialized) {
      setState(() {
        _progressValue = widget.controller.value.position.inMilliseconds /
            widget.controller.value.duration.inMilliseconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: CustomThumbShape(thumbRadius: 8.0),
        thumbColor: Colors.deepPurpleAccent,
      ),
      child: Slider(
        value: _progressValue,
        onChanged: (newValue) {
          setState(() {
            _progressValue = newValue;
          });
          final newPosition =
              newValue * widget.controller.value.duration.inMilliseconds;
          widget.controller.seekTo(Duration(milliseconds: newPosition.round()));
        },
        activeColor: const Color(0xFF57EE9D),
        inactiveColor: const Color(0xFF525252),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateProgress);
    super.dispose();
  }
}
