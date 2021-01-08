// // import 'dart:html';

// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:foodex/widgets/bottom_bar.dart';

// class RestourantList extends StatelessWidget {
//   const RestourantList(
//       {Key key,
//       // this.id,
//       this.name,
//       this.idrest,
//       // this.category,
//       this.imgUrl})
//       : super(key: key);

//   // final String id;
//   final String name;
//   final String idrest;
//   final String imgUrl;
//   // final String price;

//   // Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
//   //   return ListTile(
//   //     title: Text(document['name']),
//   //     subtitle: Text(document['idrest']),
//   //     onTap: () => navigateToDetail(document['name']),
//   //   );
//   // }

//   // navigateToDetail(DocumentSnapshots post) {
//   //   Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (context) => DetailPage(
//   //                 post: post,
//   //               )));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Кафе и рестораны'),
//       ),
//       body: StreamBuilder(
//           stream: Firestore.instance
//               .collection('restourant')
//               // .orderBy("title", descending: false)
//               .snapshots(),
//           builder: (context, snapshots) {
//             if (!snapshots.hasData) return const Text('Loading...');
//             return ListView.builder(
//               // itemExtent: 70,
//               itemCount: snapshots.data.documents.length,
//               itemBuilder: (context, index) =>
//                   _buildListItem(context, snapshots.data.documents[index]),
//             );
//           }),
//       bottomNavigationBar: BottomBar(),
//     );
//   }
// }

// class DetailPage extends StatefulWidget {
//   final DocumentSnapshot post;

//   DetailPage({this.post});

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         child: ListTile(
//           title: Text(widget.post.data["name"]),
//           subtitle: Text(widget.post.data["idrest"]),
//         ),
//       ),
//     );
//   }
// }
