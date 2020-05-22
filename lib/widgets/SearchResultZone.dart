import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tvShowSubtitles/widgets/SearchResult.dart';
import 'package:tvShowSubtitles/navigation/routes.dart';

class SearchResultZone extends StatefulWidget{
  final search; final unFocus;

  SearchResultZone({Key key, @required this.search, this.unFocus});

  @override
  State<StatefulWidget> createState() => SearchResultZoneState();
}

class SearchResultZoneState extends State<SearchResultZone> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future<dynamic> data = widget.search != ""
        ? _getShows(widget.search)
        : null;

    return
      Container(
        //color: Color.fromRGBO(0, 0, 255, 0.1),
          child: widget.search != "" ? FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                else {
                  widget.unFocus();
                  if (!snapshot.hasData) {
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('server unreachable'), backgroundColor: Colors.red));
                    return Center(
                      child: Column(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.refresh), iconSize: size.width/8, onPressed: () => setState(() {})),
                          Text('server unreachable')
                        ],
                      )
                    );
                  } else {
                    return snapshot.data.length != 0 ? Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(5),child: Text("Research Results",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12))),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                var data = snapshot.data;
                                return SearchResult(name: data[i]["name"], id: data[i]["id"]);
                              }),
                        ),
                      ],
                    ): Center(child: Text('no Shows Matching Research'));
                  }
                }
              }
          ) : Center(child: Text("Make a research")),
      );
  }

  Future<dynamic> _getShows(text) async {
    Dio dio = new Dio();
    final response = await dio.get("$server/api/search?text=$text");
    List<dynamic> data = response.data;
    return data;
  }

}