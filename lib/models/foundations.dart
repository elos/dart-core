part of core.models;

abstract class Model implements data.Record {
  String id;
  DateTime created_at;
  DateTime updated_at;
  DateTime deleted_at;

  String ID() => this.id;

  String Kind();

  bool operator ==(Model other) =>
      this.id == other.ID() && this.Kind() == other.Kind();
}
