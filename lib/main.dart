// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/discussionBoard.dart';
import 'package:flutter_app/downloadedEpisodes.dart';
import 'package:flutter_app/episodeQueue.dart';
import 'package:flutter_app/feed.dart';
import 'package:flutter_app/models/episode.dart';
import 'package:flutter_app/playing_service.dart';
import 'package:flutter_app/search.dart';
import 'package:flutter_app/testWidPage.dart';
import 'feed2.dart';
import 'player.dart';
import 'package:flutter_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  String initialRoute = '';

  LoginApp() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    this.initialRoute = _auth.currentUser == null ? '/login' : '/home';
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Login App',
      initialRoute: this.initialRoute,
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: routes,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: routes,
      title: 'Spotlight',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.black87,
        // fontFamily: '',
        appBarTheme: AppBarTheme(
            color: Colors.black87,
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    // fontFamily: 'Opensans',
                    fontSize: 20,
                  ),
                )),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22.0,
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  static MyPlayer homeWidget = new MyPlayer();

  static List<String> titles = ['Downloads', 'Browse', 'Player'];

  static List<Episode> downEps = [
    Episode(
      title:
          'Episode 1: Airbnb Brian Chesky Airbnb Brian Chesky Airbnb Brian Chesky',
      time: 6000,
      releaseOn: DateTime.now(),
      lastListenOn: DateTime.now(),
      url: 'www.google.com',
    ),
    Episode(
      title: 'Episode 2: Bill Gates Part 1',
      time: 6000,
      releaseOn: DateTime.now(),
      lastListenOn: DateTime.now(),
      url: 'www.google.com',
    ),
    Episode(
      title: 'Episode 3: TaskRabbit',
      time: 6000,
      releaseOn: DateTime.now(),
      lastListenOn: DateTime.now(),
      url: 'www.google.com',
    ),
    Episode(
      title: 'Episode 4: Fiat Pheonix',
      time: 6000,
      releaseOn: DateTime.now(),
      lastListenOn: DateTime.now(),
      url: 'www.google.com',
    ),
  ];

  final List<Widget> _children = [
    // homeWidget,
    // SafeArea(child: EpisodesList(downEps)),
    DiscusssionBoard(),
    PodFeedSmall(),
    // PodFeed(),
    // SearchWidget(),
    SafeArea(
      child: TestWid(
        mediaItems: new MediaLibrary(),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Builder(builder: (BuildContext context) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.

            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 25,
                      ),
                    ),
                    Text('Parth Champaneri',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ],
                )),
              ),
              ListTile(
                title: RaisedButton(
                  elevation: 0,
                  color: Theme.of(context).primaryColorDark,
                  child:
                      Text("Sign Out", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final User user = await _auth.currentUser;
                    if (user == null) {
                      Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text('No one has signed in.'),
                      ));
                      Navigator.pop(context);
                      return;
                    }
                    await _auth.signOut();
                    final String uid = user.email;
                    Navigator.pop(context);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(uid + ' has successfully signed out.'),
                    ));
                  },
                ),
              ),
            ],
          ),
        );
      }),
      appBar: new AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(right: 20),
          child: new Text(titles[_currentIndex],
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.comment,
              color: Colors.grey,
            ),
            label: 'Discussion',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.grey,
            ),
            label: 'Test',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

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
