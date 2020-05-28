import 'dart:io';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';


class AppDatabase {

  // File path to a file in the current directory
  static String dbName = 'tss.db';
  static DatabaseFactory dbFactory = databaseFactoryIo;
  static Database db;

  static Future<void> initDB() async{
    print('loading...');
    // We use the database factory to open the database
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = "${appDocDir.path}/$dbName";
    db = await dbFactory.openDatabase(dbPath);
    print('database ready');
  }

  static Future<int> addToStore(String storeValue, Map value) async{
    try{
      var store = intMapStoreFactory.store(storeValue);
        await store.add(db, value);
      return 1;
    }catch(e){
      return 0;
    }
  }

  static Future<List<Subtitle>> readStore(String storeValue) async{
    var store = intMapStoreFactory.store(storeValue);
    final recordSnapshot = await store.find(db);
    List<Subtitle> list = recordSnapshot.map((snapshot) => Subtitle.fromMap(snapshot.value)).toList();
    return list;
  }

  static Future<void> dropStore(String storeValue) async{
    var store = intMapStoreFactory.store(storeValue);
    store.drop(db);
    print('dropped');
  }

}








