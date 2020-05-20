class Subtitle {
  final season;
  final episode;
  final title;
  final language;
  final version;
  final link;
  final origin;

  Subtitle({
    this.season,
    this.episode,
    this.title,
    this.language,
    this.version,
    this.link,
    this.origin
  });

  static FromMap(Map map){
    if(map != null){
     if(map.length == 7){
       return new Subtitle(
           season : map["season"],
           episode: map["episode"],
           title: map["title"],
           language: map["language"],
           version: map['version'],
           link: map["link"],
           origin: map["origin"]
       );
     }else{
       return null;
     }
    }
  }
}