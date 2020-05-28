class Subtitle {
  final season;
  final episode;
  final title;
  final language;
  final version;
  final link;
  final origin;
  final show;

  Subtitle({
    this.season,
    this.episode,
    this.title,
    this.language,
    this.version,
    this.link,
    this.origin,
    this.show
  });

  showMe(){
    print(this.season+" "+this.episode+" "+this.title+" "+this.language+" "+this.version+" "+this.link+" "+this.origin+" "+this.show);
  }

  static Subtitle fromMap(Map map){
    if(map != null){
       return Subtitle(
           season : map["season"],
           episode: map["episode"],
           title: map["title"],
           language: map["language"],
           version: map['version'],
           link: map["link"],
           origin: map["origin"],
           show: map["show"]
       );
     }else{
      return null;
    }
  }

  toMap() => {
    "season" : this.season,
    "episode": this.episode,
    "title": this.title,
    "language": this.language,
    "version": this.version,
    "link": this.link,
    "origin": this.origin,
    "show": this.show
  };
}

