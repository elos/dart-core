part of core.models;

const String EventKind = "event";
const String EventSpace = "events";
Event NewEvent(Map<String, dynamic> s) => new Event.fromStructure(s);

class Event extends Property {
  String name;
  DateTime time;
  String prior_id;
  String quantity_id;
  String note_id;
  String location_id;
  List<String> tag_ids;
  String media_id;

  Event(String this.name, DateTime this.time);

  Event.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.name = s["name"];
    this.time = s["time"] == null ? null : parseDate(s["time"]);
    this.prior_id = s["prior_id"];
    this.quantity_id = s["quantity_id"];
    this.note_id = s["note_id"];
    this.location_id = s["location_id"];
    this.tag_ids = s["tag_ids"];
    this.media_id = s["media_id"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "name": this.name,
      "time": this.time,
      "prior_id": this.prior_id,
      "quantity_id": this.quantity_id,
      "note_id": this.note_id,
      "location_id": this.location_id,
      "tag_ids": this.tag_ids,
      "media_id": this.media_id,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() => EventKind;

  Future<Event> find(data.DB db, String id) {
    return db.Find(EventKind, id) as Future<Event>;
  }
}
