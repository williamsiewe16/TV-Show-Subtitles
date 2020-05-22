import 'package:flutter/material.dart';
import 'dart:math';

class CustomActionButtonWithText extends StatefulWidget{
  final IconData icon;
  final text;
  final tag;
  final visible;
  final bottom;

  const CustomActionButtonWithText({Key key, this.icon, this.text, this.tag, this.visible, this.bottom}) : super(key: key);// final Key key; final textController; final focusNode;

  @override
  State<StatefulWidget> createState() => CustomActionButtonWithTextState();
}

class CustomActionButtonWithTextState extends State<CustomActionButtonWithText> with SingleTickerProviderStateMixin{

  Animation<int> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = IntTween(begin: 0, end: 100).animate(animationController)
      ..addStatusListener((status){

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
                      label: Text(widget.text),
                      backgroundColor: Colors.blueAccent,
                      onPressed: () => _showMyDialog(),
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
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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