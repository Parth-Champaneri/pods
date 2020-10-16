import 'package:audio_service/audio_service.dart';

class MediaLibrary {
  final _items = <MediaItem>[
    MediaItem(
      id: "https://chtbl.com/track/E341G/dts.podtrac.com/redirect.mp3/rss.art19.com/episodes/2d08f85a-baf3-48b4-8815-16fa295037e6.mp3",
      album: "Masters of Scale",
      title: "1. Airbnb's Brian Chesky in Handcrafted",
      artist: "Reid Hoffman",
      duration: Duration(milliseconds: 28622680),
      artUri:
          "https://content.production.cdn.art19.com/images/69/6e/7c/4a/696e7c4a-a7e8-4fb4-8a6f-e9eea70fa13c/9438806119cac21fa439cb167eb3ede90a2fb3e04c2b42f434fc6393a9008ceefd466aa848fa137033393fc3051355d989756de55b9edf5e9b1333687010249b.jpeg",
    ),
    MediaItem(
      id: "https://chtbl.com/track/E341G/dts.podtrac.com/redirect.mp3/rss.art19.com/episodes/97b3d429-9ddf-4fa2-808b-4990c0bfade2.mp3",
      album: "Masters of Scale",
      title: "2. Raise more money than you need, w/Minted's Mariam Naficy",
      artist: "Reid Hoffman",
      duration: Duration(milliseconds: 1728000),
      artUri:
          "https://content.production.cdn.art19.com/images/00/5f/51/47/005f5147-4cc5-4b53-9951-0229093e5377/1636b93eea33258bcc0bbe27cbabff74ae2eaa51d53fa397c442ae5381634d2021992657a135ae733ffef5acdce2d852f6376dbada2a5605525571566f5a438e.jpeg",
    ),
  ];

  List<MediaItem> get items => _items;
}
