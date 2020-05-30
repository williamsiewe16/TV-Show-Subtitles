import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/services/Providers/subtitlesListService.dart';
import 'package:tvShowSubtitles/widgets/CustomFloatingActionButton.dart';
import 'package:tvShowSubtitles/widgets/CustomSliverAppBar.dart';
import 'package:tvShowSubtitles/widgets/SubtitleListZone.dart';
import 'package:tvShowSubtitles/services/api.dart';

class SubtitlesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SubtitlesScreenState();
}

class SubtitlesScreenState extends State<SubtitlesScreen>{

  List<Subtitle> subtitles = [];
  Future<dynamic> data;
  Future<dynamic> image;
  String backgroundImage;
  GlobalKey<CustomSliverAppBarState> appBarKey;
  GlobalKey<SubtitleListZoneState> listKey;
  String lastSeason;
  bool mustDownloadTester = true;

  void initState() {
    super.initState();
    appBarKey = GlobalKey<CustomSliverAppBarState>();
    listKey = GlobalKey<SubtitleListZoneState>();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Map show = ModalRoute.of(context).settings.arguments; var idShow = show["id"], showName = show["name"];
    data = getSubtitles(idShow);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            CustomSliverAppBar(key: appBarKey, title: showName)
          ];
        },
        body: Container(
        width: size.width,
        child: /*Text('google')*/ Consumer<SubtitlesListService>(
          builder: (context,subtitlesListService,child){
            if(subtitlesListService.existsShow(idShow)){
              print('ana');
              show["lastSeason"] = subtitlesListService.getShow(idShow)["lastSeason"];
              return SubtitleListZone(key: listKey, subtitles: subtitlesListService.getShow(idShow)["subtitles"], show: show, myKey: listKey);
            }else{
              print('bnb');
              return FutureBuilder(
                  future: data,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //  getImages(showName,new Subtitle());
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
                        var subtitlesMap = snapshot.data["addic7ed"]["subtitles"]; subtitles = <Subtitle>[];
                        for(var i=0; i<subtitlesMap.length; i++ ) {
                          subtitlesMap[i]["origin"] = "addic7ed";
                          subtitlesMap[i]["show"] = showName;
                          var sub = Subtitle.fromMap(subtitlesMap[i]);
                          subtitles.add(sub);
                        }
                        if(backgroundImage == null) getImages(subtitles[0]);
                        subtitlesListService.addSubtitlesToShow(show,subtitles,snapshot.data["lastSeason"]);
                        show["lastSeason"] = subtitlesListService.getShow(idShow)["lastSeason"];
                        return SubtitleListZone(key: listKey, subtitles: subtitlesListService.getShow(idShow)["subtitles"], show: show, myKey: listKey);
                      }
                    }
                  }
              );
            }
          },
        )

        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getImages(subtitle){
      image = getFutureImage(subtitle).then((data){
        if(data != null){
          backgroundImage = data["imageURL"];
          appBarKey.currentState.updateFound(data["imageURL"]);
        }
      });
  }






}