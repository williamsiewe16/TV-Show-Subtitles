import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';

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
    title = "${widget.show} - ${widget.subtitle.season}x${widget.subtitle.episode} - ${widget.subtitle.title}.${widget.subtitle.version}.${widget.subtitle.language}";
  }

  @override
  Widget build(BuildContext context) {
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
    var url = "$server/api/download/subtitle";
    Dio dio = new Dio();
    try{
      var response = await dio.post(url,data: {"subtitle": widget.subtitle.toMap(), "fileName": title});
      var downloadUrl = "$server/${response.data["fileUrl"]}";
    print(downloadUrl);
    }catch(e){
      print(e);
    }
  }

}