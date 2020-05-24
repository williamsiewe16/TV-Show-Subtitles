import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/services/notifiers.dart';
import 'package:tvShowSubtitles/widgets/CustomActionButtonWithText.dart';
import 'dart:math';

import 'package:tvShowSubtitles/widgets/SubtitleListZone.dart';

class CustomFloatingActionButton extends StatefulWidget{
  final Key key; final show; final GlobalKey<SubtitleListZoneState> listKey; final subtitles; //final textController; final focusNode;
  CustomFloatingActionButton({@required this.key, this.show, @required this.listKey, @required this.subtitles});

  @override
  State<StatefulWidget> createState() => CustomFloatingActionButtonState();
}

class CustomFloatingActionButtonState extends State<CustomFloatingActionButton> with SingleTickerProviderStateMixin{

  Animation<int> buttonAnimation;
  AnimationController buttonAnimationController;
  IconData icon = Icons.sort;
  var filter = {"season": null, "language": null, "episode": null};
  var bool = false;

  GlobalKey<CustomActionButtonWithTextState> seasonKey = GlobalKey<CustomActionButtonWithTextState>();
  GlobalKey<CustomActionButtonWithTextState> episodeKey = GlobalKey<CustomActionButtonWithTextState>();
  GlobalKey<CustomActionButtonWithTextState> languageKey = GlobalKey<CustomActionButtonWithTextState>();


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
    SubtitlesListService subtitlesListService = Provider.of<SubtitlesListService>(context);
    /* print("---");
         print(subtitles);
         print('---');*/
      var seasonData = {"text": "Seasons", "data": widget.show["lastSeason"]};
        var episodeData = {"text": "Episodes", /*"data": widget.subtitles*/};
         var languageData = {"text": "Languages", "data": Set.of(widget.subtitles.map((f) => f.language).toList()).toList()};
          return Stack(
            children: <Widget>[
              CustomActionButtonWithText(key: seasonKey, filterButtonKey: widget.key, icon: Icons.library_books, utils: seasonData, tag: "btn1", visible: bool, bottom: 155.0),
              CustomActionButtonWithText(key: episodeKey, filterButtonKey: widget.key, icon: Icons.subtitles, utils: episodeData, tag: "btn3", visible: bool, bottom: 105.0),
              CustomActionButtonWithText(key: languageKey, filterButtonKey: widget.key, icon: Icons.language, utils: languageData, tag: "btn2", visible: bool, bottom: 55.0),
              Positioned(
                bottom: 10,  right: 10,
                child: AnimatedBuilder(
                  animation: buttonAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return Transform.rotate(
                      angle: buttonAnimationController.value*9*pi/4,
                      child: FloatingActionButton(
                        heroTag: "btn0",
                        child: Icon(icon),
                        backgroundColor: backColor,
                        onPressed: () => toggleButtonAnimation(),
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
      if(bool) sort();
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

  void sort(){
    var season = seasonKey.currentState.season;
    var episode = episodeKey.currentState.episode;
    var language = languageKey.currentState.language;
    print("--- $season --- $episode --- $language ---");
     var sortList = widget.subtitles.where((sub){
       var bool = true;
       if(season != null) bool &= sub.season == season.toString();
         if(episode != null) bool &= sub.episode == episode.toString();
           if(language != null) bool &= sub.language == language.toString();
       return bool;
     }).toList();
     widget.listKey.currentState.updateSubtitlesList(sortList);
  }

  void subButtonsToggleAnimate(){
    seasonKey.currentState.toggleAnimation();
    episodeKey.currentState.toggleAnimation();
    languageKey.currentState.toggleAnimation();
  }

  @override
  void dispose() {
    buttonAnimationController.dispose();
    super.dispose();
  }
}