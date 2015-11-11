part of core.models;

const String SessionKind = "session";
const String SessionSpace = "sessions";
Session NewSession(Map<String, dynamic> s) => new Session.fromStructure(s);

class Session extends Property {
  // --- Properties {{{

  String token;
  int expires_after;
  String credential_id;

  // --- }}}

  // --- Record Implementation {{{
  String Kind() {
    return SessionKind;
  }

  Session.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.token = s['token'];
    this.expires_after = s['expires_after'];
    this.credential_id = s['credential_id'];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "token": this.token,
      "expires_after": this.expires_after,
      "credential_id": this.credential_id,
    };

    s.addAll(super.Structure());

    return s;
  }
  // --- }}}

  // --- Static Methods (find, authenticate) {{{

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

  // --- }}}
}
