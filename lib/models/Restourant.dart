import 'package:cloud_firestore/cloud_firestore.dart';

class Resto {
  final String name;
  final String idrest;
  final String imgurl;

  Resto(this.name, this.idrest, this.imgurl);

  Future<void> addData(itemData) async {
    Firestore.instance.collection("restourant").add(itemData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await Firestore.instance
        .collection("restourant")
        .orderBy("date", descending: true)
        .snapshots();
  }
}
