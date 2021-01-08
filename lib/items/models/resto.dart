import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeData {
  final DocumentReference reference;
  String name;
  String idrest;
  String imgurl;
  int minorder;

  EmployeeData.data(this.reference,
      [this.name, this.idrest, this.imgurl, this.minorder]);

  factory EmployeeData.from(DocumentSnapshot document) => EmployeeData.data(
      document.reference,
      document.data['name'],
      document.data['idrest'],
      document.data['imgurl'],
      document.data['minorder']);

  void save() {
    reference.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'idrest': idrest,
      'imgurl': imgurl,
      "minorder": minorder
    };
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ItemsBloc {
//   ItemsBloc() {
//     update = StreamController();
//     product = Firestore.instance
//         .collection("items")
//         .orderBy("title", descending: false)
//         .snapshots()
//         .map((raw) => raw.documents.map((e) => Product.fromSnapshot(e)));
//   }
//   StreamController update;
//   Stream<List<Product>> product;

//   void dispose() {
//     update.close();
//   }
// }

// // Модель "Продукт"
// @immutable
// class Product {
//   final String title;
//   final String idrest;

//   Product({this.title, this.idrest});

//   factory Product.fromSnapshot(DocumentSnapshot snapshot) {
//     return Product(
//       title: snapshot['title'],
//       idrest: snapshot['idrest'],
//     );
//   }
// }

// // Тут Statefull widget

// // Далее пишу его тело
// // ....

// class ExPage extends StatefulWidget {
//   ExPage({Key key}) : super(key: key);

//   @override
//   _ExPageState createState() => _ExPageState();
// }

// class _ExPageState extends State<ExPage> {
//   ItemsBloc bloc;

//   @override
//   void initState() {
//     super.initState();
//     bloc = ItemsBloc();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     bloc.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder(
//             stream: bloc.product,
//             builder: (context, snapshot) {
//               // Отследить snapshot.hasData и ошибки
//               return ListView.builder(
//                 // itemCount: snapshot.data.lenght,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(snapshot.data[index].title),
//                 ),
//               );
//             }));
//   }
// }
