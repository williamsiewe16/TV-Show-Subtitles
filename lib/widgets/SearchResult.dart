import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget{
  final name;
  final id;
  final onTap;

  SearchResult({Key key, @required this.name, @required this.id, @required this.onTap});

  @override
  State<StatefulWidget> createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult>{
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: IconButton(icon: Icon(Icons.search)),
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.id),
        onTap: (){
          print(widget.id);
          Navigator.of(context).pushNamed('/subtitles',arguments: {"name": widget.name, "id": widget.id});
        }
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}