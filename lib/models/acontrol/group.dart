part of core.models;

const String GroupKind = "group";
const String GroupSpace = "groups";
Group NewGroup(Map<String, dynamic> s) => new Group.fromStructure(s);

class Group extends Property {
  String name;
  int access;
  List<String> grantee_ids;
  List<String> context_ids;

  Group(this.name, this.access, owner_id) {
    this.owner_id = owner_id;
  }

  Group.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.name = s['name'];
    this.access = s['access'];

    this.grantee_ids = s['grantee_ids'];
    this.context_ids = s['context_ids'];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "name": this.name,
      "access": this.access,
      "grantee_ids": this.grantee_ids,
      "context_ids": this.context_ids,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return GroupKind;
  }

  static Future<Group> find(data.DB db, String id) {
    return db.Find(GroupKind, id) as Future<Group>;
  }
}
