part of core.models;

const String GroupKind = "group";
const String GroupSpace = "groups";

class Group extends Property {
  String name;
  int access;
  List<String> grantee_ids;
  List<String> context_ids;

  Group(this.name, this.access, owner_id) {
    this.owner_id = owner_id;
  }

  Group.fromStructure(Map<String, dynamic> s) {
    this.id = s['id'];
    this.created_at =
        s['created_at'] == null ? null : DateTime.parse(s['created_at']);
    this.updated_at =
        s['updated_at'] == null ? null : DateTime.parse(s['updated_at']);
    this.deleted_at =
        s['deleted_at'] == null ? null : DateTime.parse(s['deleted_at']);
    this.name = s['name'];
    this.access = s['access'];

    this.owner_id = s['owner_id'];
    this.grantee_ids = s['grantee_ids'];
    this.context_ids = s['context_ids'];
  }

  String Kind() {
    return GroupKind;
  }

  static Future<Group> find(data.DB db, String id) {
    return db.Find(GroupKind, id) as Future<Group>;
  }

  Map<String, dynamic> Structure() {
    return {
      "id": this.id,
      "name": this.name,
      "owner_id": this.owner_id,
      "access": this.access
    };
  }
}

Group NewGroup(Map<String, dynamic> s) => new Group.fromStructure(s);
