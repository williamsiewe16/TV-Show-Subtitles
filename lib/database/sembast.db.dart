import 'dart:io';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';


class AppDatabase {

  // File path to a file in the current directory
  static String dbName = 'tss.db';
  static DatabaseFactory dbFactory = databaseFactoryIo;
  static Database db;

  static void initDB() async{
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
        print(db);
        await store.add(db, {"a": "b"});
       /* print(db);*/
      return 1;
    }catch(e){
      return 0;
    }
  }

  static Future<List<Map>> readStore(String storeValue) async{
    var store = intMapStoreFactory.store(storeValue);

    print(db);
    final recordSnapshot = await store.find(db);
    print(recordSnapshot.length);
    return recordSnapshot.map((snapshot) => snapshot.value).toList();
  }

}






