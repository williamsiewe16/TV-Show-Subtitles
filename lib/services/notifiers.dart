import 'package:flutter/cupertino.dart';
import 'package:tvShowSubtitles/models/Subtitle.dart';

class SubtitlesListService extends ChangeNotifier{
  List<Subtitle> _value = [];
  Map<String,Map<String,dynamic>> _valueSaved = {};



  Map<String,dynamic> getShow(idShow) => _valueSaved["$idShow"];
  bool existsShow(idShow) => (getShow(idShow) != null);
  dynamic getShowLastSeason(idShow) => _valueSaved["$idShow"]["lastSeason"];

  void addSubtitlesToShow(show, List<Subtitle> data, lastSeason){
    var idShow = show["id"], showName = show["name"];
    if(existsShow(idShow)){
      getShow(idShow)["subtitles"].addAll(data);
    }else{
      _valueSaved["$idShow"] = {};
      _valueSaved["$idShow"]["subtitles"] = <Subtitle>[];
      _valueSaved["$idShow"]["subtitles"].addAll(data);
    }
    updateShowInfos(idShow, showName, lastSeason);
  }

  void updateShowInfos(idShow, showName, lastSeason){
    if(existsShow(idShow)){
      getShow(idShow)["lastSeason"] = lastSeason;
    }else{
      _valueSaved["$idShow"] = {};
      _valueSaved["$idShow"]["subtitles"] = <Subtitle>[];
      _valueSaved["$idShow"]["lastSeason"] = lastSeason;
      _valueSaved["$idShow"]["name"] = showName;
    }
  }


  void addMultiple(List<Subtitle> data, Map show){
    var showName = show["name"], lastSeason = show["lastSeason"];
    _valueSaved[showName]["lastSeason"] = lastSeason;
    _value.addAll(data);
    notifyListeners();
  }

}