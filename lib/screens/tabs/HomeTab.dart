import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/widgets/SearchBar.dart';

class HomeTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeTabState();
}

class HomeTabState extends State{
  var searchBarKey = GlobalKey<SearchBarState>();
  TextEditingController textController = TextEditingController();


  void initState() {
    super.initState();
    textController.addListener((){
      print(textController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              title: Text("TV Show Subtitles", style: TextStyle(color: Colors.black)),
              bottomOpacity: 0.5,
              centerTitle: true,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), color: Colors.grey, onPressed: (){
                  searchBarKey.currentState.toggleAnimation();
                }),
              ],
            ),
            Positioned(top: -20,child: SearchBar(
                key: searchBarKey, textController: textController,
                color: Color.fromRGBO(250, 250, 250, 1),
            )),
            Positioned(
              top: 0,
              child: Container(
                color: Colors.red,
              ),
            )
         ]
      )
      ,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}