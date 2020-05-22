import 'package:flutter/cupertino.dart';

class SubtitlesListService extends ChangeNotifier{
  var value = [];

  void getValue () => value;

  void addMultiple(data){
    for(int i=0; i<data.length; i++){
      value.add(data[i]);
    }
    notifyListeners();
  }

  void removeMultiple(data){
    for(int i=0; i<data.length; i++){
      value.remove(data);
    }
    notifyListeners();
  }
}