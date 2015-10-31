part of core.models;

const String SessionKind = "session";
const String SessionSpace = "sessions";

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

class Session extends Model {
  String token;
  int expires_after;
  String owner_id;
  String credential_id;

  String Kind() {
    return SessionKind;
  }

  Session();

  Session.fromStructure(Map<String, dynamic> s) {
    this.id = s['id'];

    if (s['created_at'] is DateTime) {
      print("is date");
    }
    this.created_at =
        s['created_at'] == null ? null : parseDate(s['created_at']);
    this.updated_at =
        s['updated_at'] == null ? null : parseDate(s['updated_at']);
    this.deleted_at =
        s['deleted_at'] == null ? null : parseDate(s['deleted_at']);

    this.token = s['token'];
    this.expires_after = s['expires_after'];
    this.owner_id = s['owner_id'];
    this.credential_id = s['credential_id'];
  }

  static Future<Session> find(data.DB db, String id) {
    return db.Find(SessionKind, id) as Future<Session>;
  }

  static Future<Session> Authenticate(
      String host, String public, String private) {
    var completer = new Completer<Session>();
    var data = JSON.encode({"public": public, "private": private});

    HttpRequest
        .request(host + "/sessions?public=$public&private=$private",
            method: "POST", sendData: data)
        .then((req) {
      if (req.status == 200 || req.status == 201) {
        Map<String, dynamic> s = JSON.decode(req.response);
        completer.complete(new Session.fromStructure(s["data"]["session"]));
      } else {
        completer.completeError("shoot");
      }
    });

    return completer.future;
  }

  Map<String, dynamic> Structure() {
    return {"id": this.id, "token": this.token};
  }
}
