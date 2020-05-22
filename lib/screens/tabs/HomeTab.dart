import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/widgets/SearchBar.dart';
import 'package:tvShowSubtitles/widgets/SearchResultZone.dart';

class HomeTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeTabState();
}

class HomeTabState extends State{
  var searchBarKey = GlobalKey<SearchBarState>();
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var searchText = "";
  var previousSearchText = "";


  void initState() {
    super.initState();
    textController.addListener((){
      if(textController.text != previousSearchText){
        setState(() => searchText = textController.text);
        previousSearchText = searchText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:Stack(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              title: Text("TV Show Subtitles", style: TextStyle(color: Colors.black)),
              bottomOpacity: 0.5,
              centerTitle: true,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), color: Colors.grey, onPressed: () => searchBarKey.currentState.toggleAnimation()),
                IconButton(icon: Icon(Icons.share), color: Colors.grey, onPressed: () => Navigator.of(context).pushNamed('/subtitles',arguments: {"name": "Batwoman", "id": 7533})
                ),
              ],
            ),
            Positioned(
                top: -15,
                child: SearchBar(
                    key: searchBarKey,
                    focusNode: focusNode,
                    textController: textController,
                    color: Color.fromRGBO(250, 250, 250, 1)
                )
            ),
             Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
                color: backColor,
                child: Column(
                  children: <Widget>[
                    Expanded(child: SearchResultZone(search: searchText, unFocus: removeSearchBarFocus))
                  ],
                ),
             ),
         ]
      )
      ,
    );
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  removeSearchBarFocus(){
    focusNode.unfocus();
  }
}