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

  Future<dynamic> image;
  ValueNotifier<String> tester = ValueNotifier<String>("not");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('built');
    var size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.width/2,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        //key: ,
          title: RaisedButton(child: Text('${widget.title}'/*,style: TextStyle(color: Colors.redAccent)*/), onPressed: () => tester.value += "god"),
          background: ValueListenableBuilder(
            valueListenable: tester,
            builder: (BuildContext context, String value, Widget child){
              print(value);
              if(value == "not"){
                return Center(child: Text('waiting...'));
              }
              else{
                return Center(child: Text('got it'));
              }
            },
          )
      ),
    );
  }

  void getImage(String name, Subtitle subtitle){
    print('here we gooo');
      tester.value = "ready";
  }
  // image = _getFutureImage(name, subtitle);


  Future<dynamic> _getFutureImage(String name,Subtitle subtitle) async {
    Dio dio = new Dio();
    final response = await dio.get("http://www.ip-api.com/json");//"$server/api/show/image?name=$name&id=$id");
    Map<String,dynamic> data = response.data;
    return data;
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