library core;

import "dart:html" show HttpRequest;
import "dart:async";
import "dart:convert";

import "package:data/data.dart" as data;

Future<String> Authenticate(String host, String public, String private) async {
  var data = {"public": public, "private": private};
  var json = JSON.encode(data);
  print(json);
  HttpRequest req = await HttpRequest.request(
      host + "/sessions?public=$public&private=$private",
      method: "POST",
      sendData: json);
  if (req.status == 200 || req.status == 201) {
    Map<String, dynamic> s = JSON.decode(req.response);
    print(s);
    return s["data"]["session"]["token"] as String;
  } else {
    throw new Error();
  }
}

class ElosHost implements data.Host {
  final String host;
  final String access;

  ElosHost(this.host, this.access);

  Future<HttpRequest> request(String method, String url, dynamic data) async {
    print("${method} on ${host}${url}");
    return HttpRequest.request(this.host + url,
        method: method,
        requestHeaders: {"Elos-Auth": this.access},
        sendData: JSON.encode(data));
  }

  Future<HttpRequest> GET(String url, dynamic data) async {
    return request("GET", url, data);
  }

  Future<HttpRequest> POST(String url, dynamic data) async {
    return request("POST", url, data);
  }

  Future<HttpRequest> DELETE(String url, dynamic data) async {
    return request("DELETE", url, data);
  }
}
