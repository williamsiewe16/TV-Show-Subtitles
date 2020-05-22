import 'package:flutter/material.dart';

/**
 * Screens imports
 */
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/screens/SubtitlesScreen.dart';

final routes = {
  '/': (context) => HomeScreen(),
  '/subtitles': (context) => SubtitlesScreen()
};

final server = "http://192.168.43.47:6000";
final remote = {
  "addic7ed": "https://www.addic7ed.com"
};