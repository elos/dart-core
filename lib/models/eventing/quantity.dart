part of core.models;

const String QuantityKind = "quantity";
const String QuantitySpace = "quantities";
Quantity NewQuantity(Map<String, dynamic> s) => new Quantity.fromStructure(s);

class Quantity extends Property {
  double value;
  String unit;

  Quantity(double this.value, String this.unit);

  Quantity.fromStructure(Map<String, dynamic> s) {
    super.loadStructure(s);

    this.value = s['value'];
    this.unit = s['unit'];
  }

  Map<String, dynamic> Structure() {
    var s = {
      "value": this.value,
      "unit": this.unit,
    };

    s.addAll(super.Structure());

    return s;
  }

  String Kind() {
    return QuantityKind;
  }

  static Future<Quantity> find(data.DB db, String id) {
    return db.Find(QuantityKind, id) as Future<Quantity>;
  }

}


