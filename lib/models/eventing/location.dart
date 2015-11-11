part of core.models;

const String LocationKind = "location";
const String LocationSpace = "locations";
Location NewLocation(Map<String, dynamic> s) => new Location.fromStructure(s);

class Location extends Property {
  double latitude;
  double longitude;
  double altitude;

  Location(double this.latitude, double this.longitude, double this.altitude);

  Location.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.latitude = s["latitude"];
    this.longitude = s["longitude"];
    this.altitude = s["altitude"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "latitude": this.latitude,
      "longitude": this.longitude,
      "altitude": this.altitude,
    };

    s.addAll(s);

    return s;
  }

  String Kind() {
    return LocationKind;
  }

  static Future<Location> find(data.DB db, String id) {
    return db.Find(LocationKind, id) as Future<Location>;
  }
}
