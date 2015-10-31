part of core.models;

const String UserKind = "user";
const String UserSpace = "users";

class User extends Model {
  String name;
  List<String> credential_ids;
  List<String> group_ids;
  List<String> authorization_ids;
  List<String> session_ids;

  String Kind() {
    return UserKind;
  }

  User(this.name);

  User.fromStructure(Map<String, dynamic> s) {
      loadBase(s);

    this.credential_ids = s['credential_ids'];
    this.group_ids = s['group_ids'];
    this.authorization_ids = s['authorization_ids'];
    this.session_ids = s['session_ids'];

    this.name = s['name'];
  }

  Stream<Group> groups(data.DB db) {
    return db.Query(GroupKind).Where("owner_id", this.id).Execute()
        as Stream<Group>;
  }

  static Future<User> find(data.DB db, String id) {
    return db.Find(UserKind, id) as Future<User>;
  }

  Group newGroup(String name, int access) {
    return new Group(name, access, this.id);
  }

  Map<String, dynamic> Structure() {
    return {"id": this.id, "name": this.name, "group_ids": this.group_ids,};
  }
}

User NewUser(Map<String, dynamic> s) => new User.fromStructure(s);

abstract class Property extends Model {
  String owner_id;

  Future<User> user(data.DB db) => User.find(db, this.owner_id);
  Future<User> owner(data.DB db) => user(db);
}
