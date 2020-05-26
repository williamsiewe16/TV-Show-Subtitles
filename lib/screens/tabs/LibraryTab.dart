import 'package:flutter/material.dart';
import 'package:tvShowSubtitles/database/sembast.db.dart';
import 'package:tvShowSubtitles/services/Providers/downloadService.dart';
import 'package:provider/provider.dart';
import 'package:tvShowSubtitles/widgets/SubtitleDownloaded.dart';

class LibraryTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LibraryTabState();
}

class LibraryTabState extends State{
  Future<List> subtitles;

  void initState() {
    super.initState();
    subtitles = AppDatabase.readStore('subtitles');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Library')
      ),
      body: FutureBuilder(
        future: subtitles,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            if(!snapshot.hasData){
              return RefreshIndicator(
                child: Center(child: Icon(Icons.refresh, size: size.width/7, color: Colors.grey)),
                onRefresh: (){
                  setState(() => subtitles = AppDatabase.readStore('subtitles'));
                  return null;
                }
              );
            }else{
              if(snapshot.data.length != 0 ){
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,i) => SubtitleDownloaded(subtitle:snapshot.data[i])
                );
              }else{
                return Center(child: Text('No downloaded subtitles'));
              }
            }
          }
        },
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}