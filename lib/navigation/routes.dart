import 'package:flutter/material.dart';

/**
 * Screens imports
 */
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/screens/SubtitlesScreen.dart';
import 'package:tvShowSubtitles/screens/VideoPlayerScreen.dart';
import 'package:tvShowSubtitles/screens/LandingPage.dart';

final routes = {
  '/home': (context) => HomeScreen(),
  '/subtitles': (context) => SubtitlesScreen(),
    '/video': (context) => VideoPlayerScreen(),
    '/': (context) => LandingPage()
};

final server = "http://192.168.43.47:6000";
final remote = {
  "addic7ed": "https://www.addic7ed.com"
};