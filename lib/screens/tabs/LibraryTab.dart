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
  }

  @override
  Widget build(BuildContext context) {
    subtitles = AppDatabase.readStore('subtitles');
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: () => AppDatabase.dropStore('subtitles'))
        ],
      ),
      body: FutureBuilder(
        future: subtitles,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            if(!snapshot.hasData){
              print(snapshot.error);
              return RefreshIndicator(
                child: Center(child: InkWell(child: Icon(Icons.refresh, size: size.width/7, color: Colors.grey), onTap: () => setState(() => subtitles = AppDatabase.readStore('subtitles')))),
               /* onRefresh: (){print('go');//AppDatabase.dropStore('subtitles');
                 // setState(() => subtitles = AppDatabase.readStore('subtitles'));
                  return null;
                }*/
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