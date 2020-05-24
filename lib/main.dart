import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';
import 'package:provider/provider.dart';
import 'package:tvShowSubtitles/services/notifiers.dart';

void main(){
  Provider.debugCheckInvalidValueType = null;
  runApp(
      /*ChangeNotifierProvider(*/MultiProvider(
        providers: [
          /*Provider<SubtitlesListService>*/ChangeNotifierProvider(create: (context) => SubtitlesListService()),
          /*Provider<NumModel>*/ChangeNotifierProvider(create: (context) => NumModel()),
        ],
        child: TSS(),
      )
  );
}

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
      routes: /*{'/a': (context) => A(), '/b': (context) => B()},*/  routes,
      initialRoute: '/',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Gordita',
        primaryColor: Colors.redAccent,
        cursorColor: Colors.black,
      ),
     /* home: Scaffold(
        body: A()
      )*/
    );
  }
}

class NumModel extends ChangeNotifier{
  var value = 0;

  int getValue(){
    return value;
  }

  void increase(){
    value++;
    notifyListeners();
  }

  void decrease(){
    value--;
    notifyListeners();
  }
}

class B extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('B');
    return Scaffold(
      appBar: AppBar(
        title: Text('B'),
      ),
      body: Consumer<NumModel>(
        builder: (context,num,child){
           return Center(
            child: Text("${num.getValue()}"),
          );
        },
      ),
    );
  }
}

class A extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AState();
}

class AState extends State<A>{
var a = 0;

  @override
  Widget build(BuildContext context) {
    a++;
    print(a);
    return Scaffold(
      appBar: AppBar(
        title: Text('google')
      ),
      body:
         /* Consumer<NumModel>(
              builder: (context,num,child) =>*/ Row(
                children: <Widget>[
                  Text("let's go"),
                  StatefulBuilder(
                      builder: (context, setState){
                        const duration = Duration(seconds: 1);
                        Timer(duration,(){
                          print('a');
                          //Provider.of<NumModel>(context,listen: false).increase();
                        });
                        return Text('${Provider.of<NumModel>(context,listen: false).getValue()}');
                      }
                  ),
                  RaisedButton(child: Text('increase'), onPressed: () => Provider.of<NumModel>(context,listen: false).increase()),
                  RaisedButton(child: Text('decrease'), onPressed: () => Provider.of<NumModel>(context,listen: false).decrease()),
                  RaisedButton(child: Text('move'), onPressed: () => Navigator.of(context).pushNamed("/b")),

                  Consumer<NumModel>(
                    builder: (context,num,child){
                      print('hey');
                      return Center(
                        child: Text("${num.getValue()}"),
                      );
                    },
                  )
                ],
              )
         /* ),*/
    );
  }

}

