import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/rendering.dart';

class MyPlayer extends StatefulWidget {
  MyPlayer({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomeState createState() => new _MyHomeState();
}

class _MyHomeState extends State<MyPlayer> {
  AudioCache audioCache = new AudioCache();
  static String url = './MOS.mp3';
  AudioPlayer audioPlayer = new AudioPlayer();
  // AudioProvider audioProvider = new AudioProvider(url);

  // Play Controls
  List<bool> toggle_play = [false];
  Duration _duration = new Duration();
  Duration _position = new Duration();

  // for slider
  static double _value = 0;

  // Initialization of Audio Player
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            // padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Image.network(
                'https://content.production.cdn.art19.com/images/26/72/78/e3/267278e3-d103-42af-85f8-ab90ce316661/a8373d5a6e6aeacb4238ce1c0af0198119977ea40db6b0dc470a70a3c352f1fe8880b1cf9aec002793c13dfd03c375ce10804fc0e07bdef7c7ffd870d7742ed8.jpeg',
                fit: BoxFit.fitWidth),
          ),
          Text(_position.inSeconds.toString()),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: new SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.grey[200],
                trackHeight: 3.0,
                thumbColor: Colors.blue[300],
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                overlayColor: Colors.lightBlue[200].withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
              ),
              child: Slider(
                value: _position.inSeconds.toDouble(),
                min: 0.0,
                max: _duration.inSeconds.toDouble(),
                label: "$_position.inSeconds.toDouble()",
                onChanged: (value) {
                  setState(() {
                    seekToSecond(value.toInt());
                    _value = _position.inSeconds.toDouble();
                  });
                },
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                  child: new Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        child: new Material(
                      borderRadius: new BorderRadius.circular(50),
                      child: new IconButton(
                        icon: Icon(Icons.play_arrow),
                        color: Colors.lightBlue,
                        onPressed: play,
                      ),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Container(
                      alignment: Alignment.center,
                      child: ToggleButtons(
                          children: <Widget>[getState()],
                          isSelected: toggle_play,
                          color: Colors.lightBlue,
                          renderBorder: false,
                          onPressed: (int index) {
                            setState(() {
                              if (toggle_play[index]) {
                                pause();
                              } else {
                                resume();
                              }
                              toggle_play[index] = !toggle_play[index];
                            });
                          })),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                  child: new Container(
                      alignment: Alignment.centerLeft,
                      child: new Material(
                        borderRadius: new BorderRadius.circular(50),
                        child: new IconButton(
                          icon: Icon(Icons.forward_30),
                          color: Colors.lightBlue,
                          onPressed: forward30,
                        ),
                      )),
                ),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                child: new Text(
                  'Episode 1: Airbnb',
                  style: new TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 30),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: new Container(
                    alignment: Alignment.center,
                    height: 45.0,
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        borderRadius: new BorderRadius.circular(10.00)),
                    child: new Text(
                      "Download Episode",
                      style: new TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5, top: 10),
                  child: new Container(
                    alignment: Alignment.center,
                    height: 45.0,
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        borderRadius: new BorderRadius.circular(10.00)),
                    child: new Text(
                      "Share Episode",
                      style: new TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 20, top: 10),
                  child: new Container(
                    alignment: Alignment.center,
                    height: 45.0,
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        borderRadius: new BorderRadius.circular(10.00)),
                    child: new Text(
                      "Comments",
                      style: new TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  play() async {
    // String localUrl = await audioProvider.load();
    // int result = await audioPlayer.play(url, isLocal: false);
    print('play hit');
    audioPlayer = await audioCache.play('audio.mp3');
    // if (result == 1) {
    // success
    toggle_play[0] = !toggle_play[0];
    // }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  forward30() async {
    int new_position = _position.inMilliseconds + 30000;
    int result = await audioPlayer.seek(Duration(milliseconds: new_position));
    if (result == 1) {
      // success
    }
  }

  replay30() async {
    int new_position = _position.inMilliseconds - 30000;
    int result = await audioPlayer.seek(Duration(milliseconds: new_position));
    if (result == 1) {
      // success
    }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // Success
    }
  }

  resume() async {
    int result = await audioPlayer.resume();
    if (result == 1) {
      // Success
    }
  }

  getState() {
    if (toggle_play[0] == false) {
      return new Icon(Icons.play_arrow);
    } else {
      return new Icon(Icons.pause);
    }
  }
}
