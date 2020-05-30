import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:tvShowSubtitles/services/api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';
import 'package:dio/dio.dart';



class DownloadService {

  static String appDocDir = "storage/emulated/0/TVShowSubtitles";

  static Future<int> downloadFile(Subtitle subtitle) async{
    try{
      if(await checkPermission(Permission.storage)){
        /*Directory appDocDir = await getApplicationDocumentsDirectory();
        String path = "${appDocDir.path}/TSS";*/

        String path = "$appDocDir/Shows/${subtitle.show}/season ${subtitle.season}";

        Directory dir = await Directory(path).create(recursive: true);
        File file = File("$path/${subtitle.getFileName()}");
        if(await file.exists()){
          return 2;
        }else{
          try{
            var fileURL = await getFileURL(subtitle); //"https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297__340.jpg"; //
            Dio dio = new Dio();
            Response response = await dio.get(fileURL, onReceiveProgress: showDownloadProgress,
              options: Options(responseType: ResponseType.bytes, followRedirects: false, validateStatus: (status) { return status < 500; }),
            );
            var raf = file.openSync(mode: FileMode.write);
            raf.writeFromSync(response.data);
            await raf.close();

            return 4;

          }catch(e){
            return 3;
          }
        }
      }else{
        return 1;
      }
    }catch(e){
      return 0;
    }
  }

}

void showDownloadProgress(received, total) {
  if (total != -1) {
    //print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

Future<bool> checkPermission(Permission permission) async{
  PermissionStatus status = await permission.status;
  if(status == PermissionStatus.granted){
   return true;
  }else{
    status = await Permission.storage.request();
    if(status == PermissionStatus.granted){
      return true;
    }else{
      return false;
    }
  }
}