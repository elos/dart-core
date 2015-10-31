library core.api;

import "dart:async" show Future;
import "dart:convert" show JSON;
import "dart:html" show HttpRequest;

import "package:data/data.dart" as data;

const elosAuthHeader = "Elos-Auth";

class Host implements data.Host {
  final String host;
  final String accessToken;

  Host(this.host, this.accessToken);

  Future<HttpRequest> request(String method, String url, dynamic data) async {
    print("[DEBUG] $method on $host$url");
    return HttpRequest.request(this.host + url,
        method: method,
        requestHeaders: {
          elosAuthHeader: this.accessToken
        },
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
