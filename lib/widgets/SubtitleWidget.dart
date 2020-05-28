import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/database/sembast.db.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/services/api.dart';
import 'package:tvShowSubtitles/services/Providers/downloadService.dart';

class SubtitleWidget extends StatefulWidget with WidgetsBindingObserver{
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
            trailing: IconButton(icon: Icon(Icons.file_download), onPressed: () => tryDownload(context, widget.subtitle, widget.show, title)),
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

  tryDownload(context,Subtitle subtitle, String show, String title){
     DownloadService.downloadFile(subtitle, show, title).then((code){
      if(code == 0) showSnackBar(context, Colors.yellow, "Problem when trying to ask storage permission",700);
     // else if(code == 1) ;
      else if(code == 2)  showSnackBar(context, Colors.blueAccent, "File already Downloaded",700);
      else if(code == 3)  showSnackBar(context, Colors.red, "Error while downloading the file",800);
      else if(code == 4){
        showSnackBar(context, Colors.green, "Download completed: $title",1000);
        print(subtitle.toMap());
        AppDatabase.addToStore('subtitles', subtitle.toMap()).then((val) => print('$val added'));
      }
    });
  }

  showSnackBar(context, color, text, int duration){
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: duration),
      backgroundColor: color,
      content: Text('$text'),
    ));
  }

}