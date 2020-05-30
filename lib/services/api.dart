import 'package:dio/dio.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';

final apiURL = /*"https://tv-show-subtitles-api.herokuapp.com";*/ "http://192.168.43.47:6000";

Dio dio = new Dio();


Future<dynamic> getShows(text) async {
  try{
    final response = await dio.get("$apiURL/api/search?text=$text");
    List<dynamic> data = response.data;
    return data;
  }catch(e){
    print(e);
  }
}

Future<dynamic> getSubtitles(idShow) async {
  try{
    final response = await dio.get("$apiURL/api/show/$idShow");
    Map<String,dynamic> data = response.data;
    return data;
  }catch(e){
    print(e);
  }
}

Future<dynamic> getFutureImage(Subtitle subtitle) async {
  try{
    final response = await dio.get("$apiURL/api/show/image?show=${subtitle.show}&season=${subtitle.season}&episode=${subtitle.episode}&title=${subtitle.title}");//http://www.ip-api.com/json
    Map<String,dynamic> data = response.data;
    return data;
  }catch(e){
    print(e);
  }
}

Future<String> getFileURL(Subtitle sub) async{
  var url = "$apiURL/api/download/subtitle";
    try{
      var response = await dio.post(url,data: {"subtitle": sub.toMap(), "fileName": sub.getDisplayedTitle()});
      var downloadUrl = "$apiURL/${response.data["fileUrl"]}";
    print(downloadUrl);
    return downloadUrl;
    }catch(e){
      print(e);
    }
    return "";
}