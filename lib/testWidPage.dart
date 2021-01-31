import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mediaLibrary.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class TestWid extends StatelessWidget {
  final mediaItems;

  TestWid({this.mediaItems}) {}

  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(child: MainScreen(mediaItems: this.mediaItems));
  }
}

class MainScreen extends StatefulWidget {
  final mediaItems;

  MainScreen({this.mediaItems}) {
    // AudioService.start(backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint);
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Tracks the position while the user drags the seek bar.
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: StreamBuilder<ScreenState>(
        stream: _screenStateStream,
        builder: (context, snapshot) {
          final screenState = snapshot.data;
          final queue = screenState?.queue;
          final mediaItem = screenState?.mediaItem;
          final state = screenState?.playbackState;
          final processingState =
              state?.processingState ?? AudioProcessingState.none;
          final playing = state?.playing ?? false;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (processingState == AudioProcessingState.none) ...[
                RaisedButton(
                  child: Text("Start"),
                  onPressed: () {
                    AudioService.start(
                      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
                      androidNotificationChannelName: 'Audio Service Demo',
                      // Enable this if you want the Android service to exit the foreground state on pause.
                      //androidStopForegroundOnPause: true,
                      androidNotificationColor: 0xFF2196f3,
                      androidNotificationIcon: 'mipmap/ic_launcher',
                      androidEnableQueue: true,
                    );
                  },
                ),
              ] else ...[
                if (queue != null && queue.isNotEmpty)
                  Column(
                    children: [
                      if (mediaItem != null)
                        Container(
                          padding: EdgeInsets.all(25),
                          child: getImage(mediaItem),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // IconButton(
                          //   icon: Icon(Icons.skip_previous),
                          //   iconSize: 30.0,
                          //   onPressed: mediaItem == queue.first
                          //       ? null
                          //       : AudioService.skipToPrevious,
                          // ),
                          IconButton(
                            icon: Icon(Icons.favorite_border_rounded),
                            iconSize: 30.0,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.replay_10_rounded),
                            iconSize: 30.0,
                            onPressed: () {
                              AudioService.rewind();
                            },
                          ),
                          if (playing) pauseButton() else playButton(),
                          IconButton(
                            icon: Icon(Icons.forward_10_rounded),
                            iconSize: 30.0,
                            onPressed: () {
                              AudioService.fastForward();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share_outlined),
                            iconSize: 30,
                            onPressed: () {},
                          )
                          // stopButton(),
                          // IconButton(
                          //   icon: Icon(Icons.skip_next),
                          //   iconSize: 30.0,
                          //   onPressed: mediaItem == queue.last
                          //       ? null
                          //       : AudioService.skipToNext,
                          // ),
                        ],
                      ),
                    ],
                  ),
                if (mediaItem?.title != null) Text(mediaItem.title),
                positionIndicator(mediaItem, state),
                Text("Processing state: " +
                    "$processingState".replaceAll(RegExp(r'^.*\.'), '')),
                StreamBuilder(
                  stream: AudioService.customEventStream,
                  builder: (context, snapshot) {
                    return Text("custom event: ${snapshot.data}");
                  },
                ),
                StreamBuilder<bool>(
                  stream: AudioService.notificationClickEventStream,
                  builder: (context, snapshot) {
                    return Text(
                      'Notification Click Status: ${snapshot.data}',
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    ));
  }

  /// Encapsulate all the different data we're interested in into a single
  /// stream so we don't have to nest StreamBuilders.
  Stream<ScreenState> get _screenStateStream =>
      Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          AudioService.playbackStateStream,
          (queue, mediaItem, playbackState) =>
              ScreenState(queue, mediaItem, playbackState));

  IconButton playButton() => IconButton(
        icon: Icon(Icons.play_circle_fill_outlined),
        iconSize: 30.0,
        onPressed: AudioService.play,
      );

  IconButton pauseButton() => IconButton(
        icon: Icon(Icons.pause_circle_filled_outlined),
        iconSize: 30.0,
        onPressed: AudioService.pause,
      );

  IconButton stopButton() => IconButton(
        icon: Icon(Icons.stop),
        iconSize: 30.0,
        onPressed: AudioService.stop,
      );

  Widget getImage(MediaItem mediaItem) {
    if (mediaItem.artUri == null) {
      return null;
    }
    return Image.network(mediaItem.artUri);
  }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                  // Due to a delay in platform channel communication, there is
                  // a brief moment after releasing the Slider thumb before the
                  // new position is broadcast from the platform side. This
                  // hack is to hold onto seekPos until the next state update
                  // comes through.
                  // TODO: Improve this code.
                  seekPos = value;
                  _dragPositionSubject.add(null);
                },
              ),
            Text("${state.currentPosition}"),
          ],
        );
      },
    );
  }
}

// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

/// This task defines logic for playing a list of podcast episodes.
class AudioPlayerTask extends BackgroundAudioTask {
  final mediaLibrary = new MediaLibrary();
  AudioPlayer _player = new AudioPlayer();
  AudioProcessingState _skipState;
  Seeker _seeker;
  StreamSubscription<PlaybackEvent> _eventSubscription;

  List<MediaItem> get queue => mediaLibrary.items;
  int get index => _player.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    // We configure the audio session for speech since we're playing a podcast.
    // You can also put this in your app's initialisation if your app doesn't
    // switch between two types of audio as this example does.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) AudioServiceBackground.setMediaItem(queue[index]);
    });

    // Propagate all events from the audio player to AudioService clients.
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });
    // Special processing for state transitions.
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          // In this example, the service stops when reaching the end.
          onStop();
          break;
        case ProcessingState.ready:
          // If we just came from skipping between tracks, clear the skip
          // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });

    // Load and broadcast the queue
    AudioServiceBackground.setQueue(queue);
    try {
      await _player.load(ConcatenatingAudioSource(
        children:
            queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
      // In this example, we automatically start playing on start.

      // Don't automatically start on play
      // onPlay();
    } catch (e) {
      print("Error: $e");
      onStop();
    }
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {
    // Then default implementations of onSkipToNext and onSkipToPrevious will
    // delegate to this method.
    final newIndex = queue.indexWhere((item) => item.id == mediaId);
    if (newIndex == -1) return;
    // During a skip, the player may enter the buffering state. We could just
    // propagate that state directly to AudioService clients but AudioService
    // has some more specific states we could use for skipping to next and
    // previous. This variable holds the preferred state to send instead of
    // buffering during a skip, and it is cleared as soon as the player exits
    // buffering (see the listener in onStart).
    _skipState = newIndex > index
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    // This jumps to the beginning of the queue item at newIndex.
    _player.seek(Duration.zero, index: newIndex);
  }

  @override
  Future<void> onPlay() => _player.play();

  @override
  Future<void> onPause() => _player.pause();

  @override
  Future<void> onSeekTo(Duration position) => _player.seek(position);

  @override
  Future<void> onFastForward() => _seekRelative(Duration(seconds: 30));

  @override
  Future<void> onRewind() => _seekRelative(Duration(seconds: -30));

  @override
  Future<void> onSeekForward(bool begin) async => _seekContinuously(begin, 1);

  @override
  Future<void> onSeekBackward(bool begin) async => _seekContinuously(begin, -1);

  @override
  Future<void> onStop() async {
    await _player.pause();
    await _player.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await _broadcastState();
    // Shut down this task
    await super.onStop();
  }

  /// Jumps away from the current position by [offset].
  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _player.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (newPosition > mediaItem.duration) newPosition = mediaItem.duration;
    // Perform the jump via a seek.
    await _player.seek(newPosition);
  }

  /// Begins or stops a continuous seek in [direction]. After it begins it will
  /// continue seeking forward or backward by 10 seconds within the audio, at
  /// intervals of 1 second in app time.
  void _seekContinuously(bool begin, int direction) {
    _seeker?.stop();
    if (begin) {
      _seeker = Seeker(_player, Duration(seconds: 10 * direction),
          Duration(seconds: 1), mediaItem)
        ..start();
    }
  }

  /// Broadcasts the current state to all clients.
  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      processingState: _getProcessingState(),
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_player.processingState) {
      case ProcessingState.none:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;
  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}

// An object that performs interruptable sleep.
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
