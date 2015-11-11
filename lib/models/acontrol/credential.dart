part of core.models;

const String CredentialKind = "credential";
const String CredentialSpace = "credentials";
Credential NewCredential(Map<String, dynamic> s) =>
    new Credential.fromStructure(s);

class Credential extends Property {
  String public;
  String private;
  String spec;
  String name;

  List<String> session_ids;

  Credential(String this.public, String this.private, String this.spec,
      String this.name);

  Credential.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.public = s["public"];
    this.private = s["private"];
    this.spec = s["spec"];
    this.name = s["name"];
    this.session_ids = s["session_ids"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "public": this.public,
      "private": this.private,
      "spec": this.spec,
      "name": this.name,
      "session_ids": this.session_ids,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return CredentialKind;
  }

  static Future<Credential> find(data.DB db, String id) {
    return db.Find(CredentialKind, id) as Future<Credential>;
  }
}
