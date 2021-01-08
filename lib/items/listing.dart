// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:extended_sliver/extended_sliver.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'models/items.dart';
// import 'models/resto.dart';

// class Listing extends StatelessWidget {
//   // Declare a field that holds the Todo.
//   final ItemsData itemsdata;

//   // In the constructor, require a Todo.
//   Listing({Key key, @required this.itemsdata}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Use the Todo to create the UI.
//     return SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 builder (context, index)[
//             ListTile(
//               title: Text('hi'),
//             ),
//             ListTile(
//               title: Text('hi'),
//             ),
//           ]),

//     );
//   }
// }

// ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: productData.items.length,
//                       itemBuilder: (context, int index) =>
//                           ChangeNotifierProvider.value(

//                             value: productData.items[index],
//                             child: ItemCard(),
//                           )

//                       // ItemCard(product: productData.items[index]),

//                       ),
