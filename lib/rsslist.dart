import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class MediaItems {
  final rssShow;
  var _items;
  MediaItems({this.rssShow}) {
    this.runRss(this.rssShow);
  }

  Future<List<Object>> runRss(rssShow) async {
    var client = http.Client();
    // var response = await client.get('https://rss.art19.com/masters-of-scale');
    var response = await client.get(rssShow);
    var channel = RssFeed.parse(response.body);

    this._items = channel.items.sublist(0, 2);

    // this.items.sublist(0, 2).forEach((item) {
    //   print(item.title);
    //   print(item.description);
    //   print(item.pubDate);
    //   print(item.media);
    //   print(item.itunes.image.href);
    //   print(item.media.contents);
    //   print(item.media);
    //   print(item.enclosure.url);
    //   print(item.enclosure.length);
    //   print(item.dc);
    // });
    client.close();
    return this.items;
  }

  List<Object> get items => _items;
}

void main() async {
  var rssShow = 'https://rss.art19.com/masters-of-scale';

  var client = http.Client();
  // var response = await client.get('https://rss.art19.com/masters-of-scale');
  var response = await client.get(rssShow);
  var channel = RssFeed.parse(response.body);

  // this._items = channel.items.sublist(0, 2);

  channel.items.sublist(0, 2).forEach((item) {
    print(item.title);
    // print(item.description);
    // print(item.pubDate);
    print(item.media);
    // print(item.itunes.image.href);
    // print(item.media.contents);
    print(item.media);
    print(item.enclosure.url);
    print(item.enclosure.length);
    print(item.dc);
  });
  client.close();
}
