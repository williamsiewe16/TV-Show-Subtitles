import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/services/api.dart';

class SubtitleWidget extends StatefulWidget{
  final Subtitle subtitle;
  final show;

  SubtitleWidget({@required this.subtitle, this.show});

  @override
  State<StatefulWidget> createState() => SubtitleWidgetState();
}

class SubtitleWidgetState extends State<SubtitleWidget>{
  var title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = "${widget.show} - ${widget.subtitle.season}x${widget.subtitle.episode} - ${widget.subtitle.title}.${widget.subtitle.version}.${widget.subtitle.language}";

    return Column(
      children: <Widget>[
        ListTile(
            leading: IconButton(icon: Icon(Icons.subtitles)),
            trailing: IconButton(icon: Icon(Icons.file_download), onPressed: () => download()),
            title: Text("$title")
        ),
        Divider()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void download() async{
   await getFileURL(widget.subtitle, title);
    try{
      /*Directory dir = await new Directory('dir/path').create(recursive: true);
      print(dir.path);*/
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      print("$appDocPath");
    }catch(e){
      print(e);
    }

  }

}