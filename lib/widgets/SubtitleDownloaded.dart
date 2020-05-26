import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/services/api.dart';
import 'package:tvShowSubtitles/services/Providers/downloadService.dart';

class SubtitleDownloaded extends StatefulWidget with WidgetsBindingObserver{
  final Subtitle subtitle;

  SubtitleDownloaded({@required this.subtitle});

  @override
  State<StatefulWidget> createState() => SubtitleDownloadedState();
}

class SubtitleDownloadedState extends State<SubtitleDownloaded>{
  var title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = "${widget.subtitle.show} - ${widget.subtitle.season}x${widget.subtitle.episode} - ${widget.subtitle.title}.${widget.subtitle.version}.${widget.subtitle.language}";

    return Column(
      children: <Widget>[
        ListTile(
            leading: IconButton(icon: Icon(Icons.subtitles)),
            trailing: IconButton(icon: Icon(Icons.file_download), onPressed: (){}),
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

}