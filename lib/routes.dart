import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/testWidPage.dart';
import 'feed2.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/discussion': (BuildContext context) => new PodFeedSmall(),
  '/player': (BuildContext context) => new TestWid(),
  '/home': (BuildContext context) => new MyApp(),
  '/': (BuildContext context) => new LoginScreen(),
};
