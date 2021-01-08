import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsData {
  final DocumentReference reference;
  String title;
  String idrest;

  ItemsData.data(this.reference, [this.title, this.idrest]);

  factory ItemsData.from(DocumentSnapshot document) => ItemsData.data(
      document.reference, document.data['title'], document.data['idrest']);

  void save() {
    reference.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {'name': title, 'idrest': idrest};
  }
}
