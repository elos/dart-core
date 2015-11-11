part of core.models;

const String NoteKind = "note";
const String NoteSpace = "notes";
Note NewNote(Map<String, dynamic> s) => new Note.fromStructure(s);

class Note extends Property {
  String text;

  Note(String this.text);

  Note.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.text = s["text"];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "text": this.text,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return NoteKind;
  }

  static Future<Note> find(data.DB db, String id) {
    return db.Find(NoteKind, id) as Future<Note>;
  }
}
