import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/widgets/CustomActionButtonWithText.dart';
import 'dart:math';

class CustomFloatingActionButton extends StatefulWidget{
  final Key key; final List<Subtitle> subtitles; //final textController; final focusNode;
  CustomFloatingActionButton({@required this.key, @required this.subtitles});

  @override
  State<StatefulWidget> createState() => CustomFloatingActionButtonState();
}

class CustomFloatingActionButtonState extends State<CustomFloatingActionButton> with SingleTickerProviderStateMixin{

  Animation<int> buttonAnimation;
  AnimationController buttonAnimationController;
  IconData icon = Icons.sort;
  var bool = false;

  GlobalKey<CustomActionButtonWithTextState> key1 = GlobalKey<CustomActionButtonWithTextState>();
  GlobalKey<CustomActionButtonWithTextState> key2 = GlobalKey<CustomActionButtonWithTextState>();
  GlobalKey<CustomActionButtonWithTextState> key3 = GlobalKey<CustomActionButtonWithTextState>();


  @override
  void initState() {
    super.initState();
    buttonAnimationController = AnimationController(duration: const Duration(milliseconds: 170), vsync: this);
    buttonAnimation = IntTween(begin: 0, end: 100).animate(buttonAnimationController)
      ..addStatusListener((status){
        if(status == AnimationStatus.dismissed) icon = Icons.sort;
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        /*Positioned(
          bottom: 50, right: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
                Column(
                  children: <Widget>[*/
        CustomActionButtonWithText(key: key1, icon: Icons.library_books, text: "Seasons",tag: "btn1", visible: bool, bottom: 150.0),
        CustomActionButtonWithText(key: key2, icon: Icons.subtitles, text: "Episodes",tag: "btn3", visible: bool, bottom: 100.0),
        CustomActionButtonWithText(key: key3, icon: Icons.language, text: "Languages",tag: "btn2", visible: bool, bottom: 50.0),
               /*   ],
                ),
            ],
          ),
        ),*/
        Positioned(
          bottom: 0,  right: 0,
          child: AnimatedBuilder(
            animation: buttonAnimationController,
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                angle: buttonAnimationController.value*9*pi/4,
                child: FloatingActionButton(
                  heroTag: "btn0",
                  child: Icon(icon),
                  backgroundColor: backColor,
                  onPressed: (){
                       var a = widget.subtitles.where((val) => val.language == "French").toList();
                       print(a.length);
                  }// toggleButtonAnimation(),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  void toggleButtonAnimation(){
    setState(() {
     icon = Icons.add;
     bool = !bool;
     subButtonsToggleAnimate();
    });
    var status = buttonAnimation.status;
    if (status == AnimationStatus.completed || status == AnimationStatus.forward) {
      buttonAnimationController.reverse();
    } else if (status == AnimationStatus.dismissed || status == AnimationStatus.reverse) {
      buttonAnimationController.forward();
    }
  }

  void subButtonsToggleAnimate(){
    key1.currentState.toggleAnimation();
    key2.currentState.toggleAnimation();
    key3.currentState.toggleAnimation();
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
    super.dispose();
  }
}