part of core.models;

const String SessionKind = "session";
const String SessionSpace = "sessions";

class Session extends Model {
  String token;
  int expires_after;
  String owner_id;
  String credential_id;

  String Kind() {
    return SessionKind;
  }

  Session.fromStructure(Map<String, dynamic> s) {
      loadBase(s);

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

Session NewSession(Map<String, dynamic> s) => new Session.fromStructure(s);
