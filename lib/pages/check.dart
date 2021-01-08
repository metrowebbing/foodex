import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStore {
  Future<void> addData(itemData) async {
    Firestore.instance.collection("items").add(itemData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance
        .collection("items")
        .orderBy("date", descending: true)
        .snapshots();
  }
}
