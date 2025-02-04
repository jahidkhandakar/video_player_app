import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Player",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //*__________________Reverse Button________________
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(16),
                            side: BorderSide(color: Colors.blue, width: 2),
                          ),
                          onPressed: () {
                            final currentPosition = _controller.value.position;
                            final newPosition =
                                currentPosition - Duration(seconds: 10);
                            _controller.seekTo(newPosition);
                          },
                          child: Icon(Icons.replay_10),
                        ),
                        SizedBox(width: 20),
                        //*__________________Play/Pause Button________________
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(16),
                            side: BorderSide(color: Colors.blue, width: 2),
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: _controller.value.isPlaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                        ),
                        SizedBox(width: 20),
                        //*__________________Forward Button________________
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.all(16),
                            side: BorderSide(color: Colors.blue, width: 2),
                          ),
                          onPressed: () {
                            final currentPosition = _controller.value.position;
                            final newPosition =
                                currentPosition + Duration(seconds: 10);
                            _controller.seekTo(newPosition);
                          },
                          child: Icon(Icons.forward_10),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                child: Text("Loading..."),
              ),
      ),
    );
  }
}
