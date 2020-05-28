import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/services/api.dart';
import 'package:tvShowSubtitles/services/Providers/downloadService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SubtitleDownloaded extends StatefulWidget with WidgetsBindingObserver{
  final Subtitle subtitle;

  SubtitleDownloaded({@required this.subtitle});

  @override
  State<StatefulWidget> createState() => SubtitleDownloadedState();
}

class SubtitleDownloadedState extends State<SubtitleDownloaded>{
  var title;
  var path;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = "${widget.subtitle.show} - ${widget.subtitle.season}x${widget.subtitle.episode} - ${widget.subtitle.title}.${widget.subtitle.version}.${widget.subtitle.language}";

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
              leading: IconButton(icon: Icon(Icons.subtitles), onPressed: () => print(path)),
              trailing: IconButton(icon: Icon(Icons.play_arrow), onPressed: () => checkVideo(context)),
              title: Text("$title")
          ),
        ),
        Divider()
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> checkVideo(context) async{
   // if(await checkPermission(Permission.storage)){
   //   File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
      Navigator.of(context).pushNamed('/video');
   //   path = video;
   //   return video.path;
  //  }
    return "";
  }
}