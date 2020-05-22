import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:tvShowSubtitles/services/services.dart';

void main() => runApp(
   MultiProvider(
     providers: [
       Provider<SubtitlesListService>(create: (context) => SubtitlesListService())
     ],
     child: TSS(),
   )
);

class TSS extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white
      )
    );
    return MaterialApp(
      title: 'TV Show Subtitles',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Gordita',
        primaryColor: Colors.redAccent,
        cursorColor: Colors.black,
      )
    );
  }
}

