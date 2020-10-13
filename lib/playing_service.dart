import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/rsslist.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayingService extends StatefulWidget {
  @override
  _PlayingServiceState createState() => _PlayingServiceState();
}

class _PlayingServiceState extends State<PlayingService> {
  double _value = 0;
  bool _isplaying = false;
  double _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AudioServiceWidget(
          child: Scaffold(
        body: Center(
          child: StreamBuilder(
            stream: AudioService.playbackStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;
              final processingState = snapshot.data?.processingState ??
                  AudioProcessingState.stopped;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.grey[200],
                      trackHeight: 2.0,
                      thumbColor: Colors.blue[300],
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 7.0),
                      overlayColor: Colors.lightBlue[200].withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 15.0),
                    ),
                    child: Slider(
                      value: _value,
                      min: 0.0,
                      max: 10,
                      onChanged: (value) {},
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.forward_30_rounded),
                        onPressed: () {},
                      ),
                      if (playing)
                        IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: _pause,
                        )
                      else
                        IconButton(
                          icon: Icon(Icons.play_circle_fill_outlined),
                          onPressed: _play,
                        ),
                      IconButton(
                        icon: Icon(Icons.forward_30_rounded),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.ios_share),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  if (processingState != AudioProcessingState.stopped)
                    RaisedButton(
                      child: Text('Stop'),
                      onPressed: _stop,
                    ),
                ],
              );
            },
          ),
        ),
      )),
    );
  }

  _stop() => AudioService.stop();

  _play() async {
    if (await AudioService.running) {
      AudioService.play();
    } else {
      AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint);
    }
  }

  _pause() => AudioService.pause();
}

_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _mediaLibrary = MediaLibrary();
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();
  Seeker _seeker;

  List<MediaItem> get queue => _mediaLibrary.items;
  int get index => _audioPlayer.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    // Broadcast that we're connecting, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.connecting);
    // Connect to the URL
    await _audioPlayer.setUrl(
        "https://chtbl.com/track/E341G/dts.podtrac.com/redirect.mp3/rss.art19.com/episodes/114f01af-3635-4d64-b5f2-6e04b229ae5c.mp3");
    // Now we're ready to play

    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);

    _audioPlayer.play();
  }

// Seeker slide bar
  void _seekContinuously(bool begin, int direction) {
    _seeker?.stop();
    if (begin) {
      _seeker = Seeker(_audioPlayer, Duration(seconds: 10 * direction),
          Duration(seconds: 1), mediaItem)
        ..start();
    }
  }

  @override
  Future<void> onSeekForward(bool begin) async => _seekContinuously(begin, 1);

  @override
  Future<void> onSeekBackward(bool begin) async => _seekContinuously(begin, -1);

  @override
  Future<void> onSeekTo(Duration position) => _audioPlayer.seek(position);

  @override
  Future<void> onFastForward() => _seekRelative(fastForwardInterval);

  @override
  Future<void> onRewind() => _seekRelative(-rewindInterval);

  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _audioPlayer.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
    // Perform the jump via a seek.
    await _audioPlayer.seek(newPosition);
  }

  @override
  Future<void> onStop() async {
    // Stop playing audio
    await _audioPlayer.stop();
    // Broadcast that we've stopped
    await AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    // Shut down this background task
    await super.onStop();
  }

  @override
  Future<void> onPlay() {
    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.pause, MediaControl.stop],
        playing: true,
        processingState: AudioProcessingState.ready);
    _audioPlayer.play();
  }

  @override
  Future<void> onPause() {
    // Broadcast that we're paused, and what controls are available.
    AudioServiceBackground.setState(
        controls: [MediaControl.play, MediaControl.stop],
        playing: false,
        processingState: AudioProcessingState.ready);
    _audioPlayer.pause();
  }
}

class Seeker {
  final AudioPlayer player;
  final Duration positionInterval;
  final Duration stepInterval;
  final MediaItem mediaItem;
  bool _running = false;

  Seeker(
    this.player,
    this.positionInterval,
    this.stepInterval,
    this.mediaItem,
  );

  start() async {
    _running = true;
    while (_running) {
      Duration newPosition = player.position + positionInterval;
      if (newPosition < Duration.zero) newPosition = Duration.zero;
      if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
      player.seek(newPosition);
      await Future.delayed(stepInterval);
    }
  }

  stop() {
    _running = false;
  }
}

class Sleeper {
  Completer _blockingCompleter;

  /// Sleep for a duration. If sleep is interrupted, a
  /// [SleeperInterruptedException] will be thrown.
  Future<void> sleep([Duration duration]) async {
    _blockingCompleter = Completer();
    if (duration != null) {
      await Future.any([Future.delayed(duration), _blockingCompleter.future]);
    } else {
      await _blockingCompleter.future;
    }
    final interrupted = _blockingCompleter.isCompleted;
    _blockingCompleter = null;
    if (interrupted) {
      throw SleeperInterruptedException();
    }
  }

  /// Interrupt any sleep that's underway.
  void interrupt() {
    if (_blockingCompleter?.isCompleted == false) {
      _blockingCompleter.complete();
    }
  }
}

class SleeperInterruptedException {}

class MediaLibrary {
  final _items = <MediaItem>[
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
      album: "Science Friday",
      title: "A Salute To Head-Scratching Science",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 5739820),
      artUri:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
    MediaItem(
      id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
      album: "Science Friday",
      title: "From Cat Rheology To Operatic Incompetence",
      artist: "Science Friday and WNYC Studios",
      duration: Duration(milliseconds: 2856950),
      artUri:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ];

  List<MediaItem> get items => _items;
}
