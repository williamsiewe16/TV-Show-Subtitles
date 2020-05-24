import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tvShowSubtitles/widgets/CustomFloatingActionButton.dart';

class CustomActionButtonWithText extends StatefulWidget{
  final IconData icon;
  final utils;
  final tag;
  final visible;
  final bottom;
  final GlobalKey<CustomFloatingActionButtonState>filterButtonKey;

  const CustomActionButtonWithText({Key key, this.filterButtonKey, this.icon, this.utils, this.tag, this.visible, this.bottom}) : super(key: key);// final Key key; final textController; final focusNode;

  @override
  State<StatefulWidget> createState() => CustomActionButtonWithTextState();
}

class CustomActionButtonWithTextState extends State<CustomActionButtonWithText> with SingleTickerProviderStateMixin{

  Animation<int> animation;
  AnimationController animationController;
  TextEditingController textController;

  var season, language, episode;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = IntTween(begin: 0, end: 100).animate(animationController)
      ..addStatusListener((status){

      });
    textController = TextEditingController();
    textController.addListener(() {// setState((){
      episode = textController.text == "" ? null : textController.text;
      print(episode);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          bottom: widget.bottom+10*animationController.value, right: 0,
          child: Visibility(
            visible: widget.visible,
            child: Transform.scale(
                    scale: 0.75,
                    child: FloatingActionButton.extended(
                      heroTag: widget.tag,
                      icon: Icon(widget.icon, color: Colors.white),
                      label: Text(widget.utils["text"]),
                      backgroundColor: Colors.blueAccent,
                      onPressed: () => _showMyDialog()
                      //widget.utils["text"] == "Seasons" ? season = 1 : widget.utils["text"] == "Languages" ? language = "English" : episode = "1",
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var text = widget.utils["text"], data = widget.utils["data"]; List toUse;
        var _groupValue;

        if(text == "Seasons"){
          toUse = getAllSeasons(data);
          if(season == null) season = toUse[0];
          _groupValue = season;
        }
        else if(text == "Languages"){
          toUse = data;
          if(language == null) language = toUse[0];
        }
        return AlertDialog(
          title: Text('$text'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => SingleChildScrollView(
              child: (text == "Seasons" || text == "Languages") ?
              Column(
                children: toUse.map((val) => Row(
                    children: <Widget>[
                      Text('$val'),
                      Radio(
                      value: val,
                      groupValue: language,
                      onChanged: (val){
                        setState((){
                          language = val;
                        });
                      },
                          activeColor: Colors.blue)
                    ])
                ).toList()
              )
                  :
              TextField(
                  controller: textController, decoration: InputDecoration(hintText: "Search an episode..."),
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false)
              )
            ),
          ),
          actions: <Widget>[
            FlatButton(child: Text('ok'), onPressed: () => close(context)),
            FlatButton(child: Text('remove Filter'), onPressed: () => dismiss(context)),
          ],
        );
      },
    );
  }

  List getAllSeasons(val){
    var seasons = [];
    for(int i=val; i>0; i--) seasons.add(i);
    return List.from(seasons.reversed);
  }

  void dismiss(context){
    Navigator.of(context).pop();
    var text = widget.utils["text"];
    if(text == "Seasons") season = null;
    else if(text == "Languages") language = null;
    else textController.text = "" ;
  }

  void close(context){
    Navigator.of(context).pop();
  }


  void toggleAnimation(){
    var status = animation.status;
    if (status == AnimationStatus.completed || status == AnimationStatus.forward) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed || status == AnimationStatus.reverse) {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
    super.dispose();
  }
}