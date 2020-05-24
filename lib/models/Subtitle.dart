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

  show(){
    print(this.season+" "+this.episode+" "+this.title+" "+this.language+" "+this.version+" "+this.link+" "+this.origin);
  }

  static fromMap(Map map){
    if(map != null){
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

  toMap() => {
    "season" : this.season,
    "episode": this.episode,
    "title": this.title,
    "language": this.language,
    "version": this.version,
    "link": this.link,
    "origin": this.origin
  };
}

class A{
  final name;
  static var _instance;

  A._({this.name});

  factory A.getInstance(){
    if(_instance == null) return A._();
    return _instance;
  }
}

var a = A.getInstance();

