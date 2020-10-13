import 'package:flutter/foundation.dart';

class Episode {
  final String title;
  final int time;
  final DateTime releaseOn;
  final DateTime lastListenOn;
  final String url;

  Episode({
    @required this.title,
    @required this.time,
    @required this.releaseOn,
    @required this.lastListenOn,
    @required this.url,
  });
}
