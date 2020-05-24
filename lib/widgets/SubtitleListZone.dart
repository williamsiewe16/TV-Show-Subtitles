import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/widgets/CustomFloatingActionButton.dart';
import 'package:tvShowSubtitles/widgets/SubtitleWidget.dart';

class SubtitleListZone extends StatefulWidget{
  final Key key; final subtitles; final show; final myKey; // final focusNode;
  SubtitleListZone({@required this.key, @required this.subtitles, @required this.show, this.myKey});

  @override
  State<StatefulWidget> createState() => SubtitleListZoneState();
}

class SubtitleListZoneState extends State<SubtitleListZone>{
var subtitles;
var show;

  @override
  void initState() {
    super.initState();
    subtitles = widget.subtitles;
    show = widget.show;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        ListView.builder(
            itemCount: subtitles.length,
            itemBuilder: (context,i){
              return SubtitleWidget(subtitle:subtitles[i], show: show["name"]);
            }
        ),
        CustomFloatingActionButton(show: widget.show, listKey: widget.myKey, subtitles: widget.subtitles)
      ],
    );
  }

  void go(){
    print('go');
  }

  void updateSubtitlesList(subs) {
    setState(() {
      subtitles = subs;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}