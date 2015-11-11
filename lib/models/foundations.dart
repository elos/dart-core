part of core.models;

// Dart's DateTime.parse cannot handle nano seconds
DateTime parseDate(String s) {
  String n;
  if (s.contains(".") && s.length > 25) {
    // ms part
    n = s.split(".")[0] + s.substring(s.length - 6, s.length);
  } else {
    n = s;
  }
  return DateTime.parse(n);
}

// The base class
abstract class Model implements data.Record {
  String id;
  DateTime created_at;
  DateTime updated_at;
  DateTime deleted_at;

  String ID() => this.id;

  String Kind();

  void loadStructure(Map<String, dynamic> s) {
    this.id = s["id"];
    this.created_at =
        s['created_at'] == null ? null : parseDate(s['created_at']);
    this.updated_at =
        s['updated_at'] == null ? null : parseDate(s['updated_at']);
    this.deleted_at =
        s['deleted_at'] == null ? null : parseDate(s['deleted_at']);
  }

  Map<String, dynamic> Structure() {
    return {
      "id": this.id,
      "created_at": this.created_at,
      "updated_at": this.updated_at,
      "deleted_at": this.deleted_at,
    };
  }

  // Define the equivalence for two models to be the equality of their kind and id
  // Note that their attributes may have diverged
  bool operator ==(Model other) =>
      this.id == other.ID() && this.Kind() == other.Kind();
}

// Registers the models with the database
void RegisterModels(data.DB db) {
  db.RegisterKind(UserKind, UserSpace, NewUser);
  db.RegisterKind(GroupKind, GroupSpace, NewGroup);
  db.RegisterKind(SessionKind, SessionSpace, NewSession);
}
