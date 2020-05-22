import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/widgets/SubtitleWidget.dart';

class SubtitleListZone extends StatefulWidget{
  final Key key; final subtitles; final show;// final focusNode;
  SubtitleListZone({@required this.key, @required this.subtitles, @required this.show});

  @override
  State<StatefulWidget> createState() => SubtitleListZoneState();
}

class SubtitleListZoneState extends State<SubtitleListZone>{
var subtitles;

  @override
  void initState() {
    super.initState();
    subtitles = widget.subtitles;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: subtitles.length,
        itemBuilder: (context,i){
          return SubtitleWidget(subtitle:subtitles[i], show: widget.show);
        }
    );
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