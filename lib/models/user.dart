part of core.models;

const String UserKind = "user";
const String UserSpace = "users";
User NewUser(Map<String, dynamic> s) => new User.fromStructure(s);

class User extends Model {
  // --- Properties {{{

  String password;
  List<String> credential_ids;
  List<String> group_ids;
  List<String> authorization_ids;
  List<String> session_ids;

  // --- }}}

  // --- Record Implementation {{{
  String Kind() {
    return UserKind;
  }

  User.fromStructure(Map<String, dynamic> s) {
    loadBase(s);

    this.credential_ids = s['credential_ids'];
    this.group_ids = s['group_ids'];
    this.authorization_ids = s['authorization_ids'];
    this.session_ids = s['session_ids'];

    this.password = s['password'];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "password": this.password,
      "credential_ids": this.credential_ids,
      "group_ids": this.group_ids,
      "authorization_ids": this.authorization_ids,
      "session_ids": this.session_ids,
    };

    s.addAll(super.Structure());

    return s;
  }

  // --- }}}

  User(this.password);

  Stream<Group> groups(data.DB db) {
    return db.Query(GroupKind).Where("owner_id", this.id).Execute()
        as Stream<Group>;
  }

  Group newGroup(String name, int access) {
    return new Group(name, access, this.id);
  }

  // --- Static Methods {{{

  static Future<User> find(data.DB db, String id) {
    return db.Find(UserKind, id) as Future<User>;
  }

  // --- }}}
}

abstract class Property extends Model {
  String owner_id;

  Future<User> user(data.DB db) => User.find(db, this.owner_id);
  Future<User> owner(data.DB db) => user(db);

  Map<String, dynamic> Structure() {
    var s = {
      "owner_id": this.owner_id,
    };

    s.addAll(super.Structure());

    return s;
  }
}
