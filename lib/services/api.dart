import 'package:dio/dio.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';

final apiURL = "http://192.168.43.47:6000";

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

Future<dynamic> getFutureImage(String name,Subtitle subtitle) async {
  try{
    final response = await dio.get("$apiURL/api/show/image?show=$name&season=${subtitle.season}&episode=${subtitle.episode}&title=${subtitle.title}");//http://www.ip-api.com/json
    Map<String,dynamic> data = response.data;
    return data;
  }catch(e){
    print(e);
  }
}

Future<String> getFileURL(Subtitle sub, String fileName) async{
  var url = "$apiURL/api/download/subtitle";
    try{
      var response = await dio.post(url,data: {"subtitle": sub.toMap(), "fileName": fileName});
      var downloadUrl = "$apiURL/${response.data["fileUrl"]}";
    print(downloadUrl);
    return downloadUrl;
    }catch(e){
      print(e);
    }
}