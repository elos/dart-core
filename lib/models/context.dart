part of core.models;

const String ContextKind = "context";
const String ContextSpace = "contexts";
Context NewContext(Map<String, dynamic> s) => new Context.fromStructure(s);

class Context extends Property {
  String domain;
  List<String> ids;

  Context(String this.domain, List<String> this.ids);

  Context.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.domain = s["domain"];
    this.ids = s["ids"];
  }

  Map<String, dynamic> Structure() {
    var s = {"domain": this.domain, "ids": this.ids,};

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return ContextKind;
  }

  static Future<Context> find(data.DB db, String id) {
    return db.Find(ContextKind, id) as Future<Context>;
  }
}
