part of core.models;

const String MediaKind = "media";
const String MediaSpace = "medias";
Media NewMedia(Map<String, dynamic> s) => new Media.fromStructure(s);

class Media extends Property {
  String content;
  String codec;

  Media(String this.content, String this.codec);

  Media.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.content = s["content"];
    this.codec = s["codec"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "content": this.content,
      "codec": this.codec,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return MediaKind;
  }

  Future<Media> find(data.DB db, String id) {
    return db.Find(MediaKind, id) as Future<Media>;
  }
}
