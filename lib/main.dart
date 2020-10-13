// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/downloadedEpisodes.dart';
import 'package:flutter_app/models/episode.dart';
import 'package:flutter_app/playing_service.dart';
import 'package:flutter_app/search.dart';
import 'package:flutter_app/testWidPage.dart';
import 'player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spotlight',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Opensans',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'Opensans',
                      fontSize: 20,
                    ),
                  )),
          textTheme: TextTheme(
            headline: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: new MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 3;
  static MyPlayer homeWidget = new MyPlayer();

  static List<String> titles = ['Player', 'Downloads', 'Browse', 'Player'];

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
    homeWidget,
    EpisodesList(downEps),
    SearchWidget(),
    PlayingService()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.play_arrow,
              color: Colors.grey,
            ),
            title: new Text('Player'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.file_download,
              color: Colors.grey,
            ),
            title: new Text('Downloads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            title: new Text('Browse'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: Colors.grey,
            ),
            title: new Text('Test'),
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
