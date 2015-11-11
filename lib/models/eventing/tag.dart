part of core.models;

const String TagKind = "tag";
const String TagSpace = "tags";
Tag NewTag(Map<String, dynamic> s) => new Tag.fromStructure(s);

class Tag extends Property {
  String name;
  List<String> event_ids;

  Tag(String this.name);

  Tag.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.name = s["name"];
    this.event_ids = s["event_ids"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "name": this.name,
      "event_ids": this.event_ids,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return TagKind;
  }

  Future<Location> find(data.DB db, String id) {
    return db.Find(LocationKind, id) as Future<Location>;
  }
}
