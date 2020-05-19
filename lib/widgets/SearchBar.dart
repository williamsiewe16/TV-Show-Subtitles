import 'package:flutter/material.dart';
import 'dart:math';

class SearchBar extends StatefulWidget{
  final Key key; final color; final textController;
  SearchBar({@required this.key, @required this.color, @required this.textController});

  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin{

  Animation<int> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = IntTween(begin: 0, end: 100).animate(animationController)
    ..addListener((){

    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animationController,

      builder: (BuildContext context, Widget child) {
          return Padding(
            padding:  EdgeInsets.fromLTRB(size.width*(1-animationController.value),0,0,0),
            child: Container(
               width: size.width,
               height: 70.0,
               color: widget.color,
               child: Row(
                 children: <Widget>[
                   IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: (){
                     toggleAnimation();
                   }),
                   SizedBox(
                     width: 3*size.width/4,
                     child: TextField(
                       controller: widget.textController, decoration: InputDecoration(hintText: "Type a text...")
                     ),
                   )
                 ],
               ),
            ),
          );
      },
    );
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
    super.dispose();
  }
}