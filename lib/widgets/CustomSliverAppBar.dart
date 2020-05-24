import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';

class CustomSliverAppBar extends StatefulWidget{
  final Key key; final title; //final textController; final focusNode;
  CustomSliverAppBar({@required this.key, @required this.title});

  @override
  State<StatefulWidget> createState() => CustomSliverAppBarState();
}

class CustomSliverAppBarState extends State<CustomSliverAppBar> {

  String image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.width/2,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          title:Text('${widget.title}'),
          background: image != null ?
          Image.network(image, fit: BoxFit.cover)
              :
          Image.network("https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg", fit: BoxFit.cover)
      ),
    );
  }

  void updateFound(imageURL){
    setState(() {
      image = imageURL;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/*FutureBuilder(
                  future: image,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center();
                    }else{
                      if(!snapshot.hasData){
                        return Center();
                      }else{
                        return Image.network(
                            //  "https://www.addic7ed.com/images/showimages/279121-g7.jpg",
                               "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg",//snapshot.data["imageURL"]
                            fit: BoxFit.fill
                        );
                      }
                    }
                  },
                )*/

/* FutureBuilder(
                  future: image,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }else{
                      if(!snapshot.hasData){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.refresh), iconSize: size.width/8, onPressed: () => setState(() {})),
                            Text('server unreachable')
                          ],
                        );
                      }else{
                        return Image.network("https://data.pixiz.com/output/user/frame/preview/400x400/3/6/2/2/282263_82381.jpg", fit: BoxFit.fill);
                      }
                    }
                  },
                );*/