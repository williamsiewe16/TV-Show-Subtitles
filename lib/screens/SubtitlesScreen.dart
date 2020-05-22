import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/screens/HomeScreen.dart';
import 'package:tvShowSubtitles/widgets/CustomActionButtonWithText.dart';
import 'package:tvShowSubtitles/widgets/CustomFloatingActionButton.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';
import 'package:tvShowSubtitles/widgets/CustomSliverAppBar.dart';
import 'package:tvShowSubtitles/widgets/SubtitleListZone.dart';
import 'package:tvShowSubtitles/widgets/SubtitleWidget.dart';

class SubtitlesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SubtitlesScreenState();
}

class SubtitlesScreenState extends State<SubtitlesScreen>{

  List<Subtitle> subtitles = [];
  Future<dynamic> data;
  Future<dynamic> image;
  GlobalKey<CustomSliverAppBarState> appBarKey;
  GlobalKey<SubtitleListZoneState> listKey;

  void initState() {
    super.initState();
    appBarKey = GlobalKey<CustomSliverAppBarState>();
    listKey = GlobalKey<SubtitleListZoneState>();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Map params = ModalRoute.of(context).settings.arguments;
    data  = _getSubtitles(params["id"]);

    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: backColor,
        leading: IconButton(/*color: Colors.redAccent,*/icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text('${params["name"]}'/*,style: TextStyle(color: Colors.redAccent)*/)
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            CustomSliverAppBar(key: appBarKey, title: params["name"])
          ];
        },
        body: /*Center(child: Text('google'))*/Container(
        width: size.width,
        child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              //  getImages(params["name"],new Subtitle());
                return Center(child: CircularProgressIndicator());
              }
              else {
                if (!snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.refresh), iconSize: size.width/8, onPressed: () => setState(() {})),
                      Text('server unreachable')
                    ],
                  );
                } else {
                  var subtitlesMap = snapshot.data["addic7ed"]["subtitles"]; subtitles = [];
                  for(var i=0; i<subtitlesMap.length; i++ ) {
                    subtitlesMap[i]["origin"] = "addic7ed";
                    var sub = Subtitle.fromMap(subtitlesMap[i]);
                    subtitles.add(sub);
                  }
                  getImages(params["name"],subtitles[0]);
                  return SubtitleListZone(key: listKey, subtitles: subtitles, show: params["name"]);
                }
              }
            }
        ),
      ),
      ),
      floatingActionButton: CustomFloatingActionButton(subtitles: subtitles)
      //listKey.currentState.updateSubtitlesList(subtitles);
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getImages(name,subtitle){
    appBarKey.currentState.getImage(name, subtitle);
  }

  Future<dynamic> _getSubtitles(idShow) async {
    Dio dio = new Dio();
    final response = await dio.get("$server/api/show/$idShow");
    Map<String,dynamic> data = response.data;
    return data;
  }

}