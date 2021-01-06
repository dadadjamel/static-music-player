import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;
  //
  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration musiclength = new Duration();

  Widget slider() {
    return Container(
      width: 300,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musiclength.inSeconds.toDouble(),
          onChanged: (value){
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler=(d){
      setState(() {
        musiclength = d;
      });
    };
    _player.positionHandler=(p){
      setState(() {
        position = p;
      });
    };

    // cache.load('r3hab.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[800], Colors.blue[200]])),
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Music Beats',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text('Listen to your favorite music',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400)),
                ),
                SizedBox(height: 25),
                Center(
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage('assets/image.jpg'))),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Text('Oh la la la',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      )),
                ),
                SizedBox(height: 25),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${position.inMinutes}:${position.inSeconds.remainder(60)}'),
                          slider(),
                          Text('${musiclength.inMinutes}:${musiclength.inSeconds.remainder(60)}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              color: Colors.blue[800],
                              iconSize: 45,
                              icon: Icon(Icons.skip_previous),
                              onPressed: () {}),
                          IconButton(
                              color: Colors.blue,
                              iconSize: 75,
                              icon: Icon(playBtn),
                              onPressed: () {
                                if (!playing) {
                                  cache.play('r3hab.mp3');
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              }),
                          IconButton(
                              color: Colors.blue[800],
                              iconSize: 45,
                              icon: Icon(Icons.skip_next),
                              onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
