import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodex/domain/user.dart';
import 'package:foodex/items/resto_detail.dart';
import 'package:foodex/services/auth.dart';
import 'package:foodex/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';

import 'animator.dart';
import 'models/resto.dart';
import '../pages/drawer.dart';

class RestoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.sort, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'Рестораны и кафе',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.black54),
              onPressed: null)
        ],
      ),
      drawer: StreamProvider<User>.value(
        value: AuthService().currentUser,
        child: DrawerPage(),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('restourant')
              .orderBy('name', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: new Text('Loading...'));

            final List<DocumentSnapshot> documents = snapshot.data.documents;
            final List<EmployeeData> employeeDataList = documents
                .map((snapshot) => EmployeeData.from(snapshot))
                .toList();
            // now u can access each document by simply specifying its number
            // u can also use list view to display every one of them
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, int index) => WidgetANimator(
                Card(
                  margin: EdgeInsets.all(15),
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestoDetail(
                              employeedata: employeeDataList[index]),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            CachedNetworkImage(
                              imageUrl: employeeDataList[index].imgurl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Colors.black.withOpacity(0.6),
                                          Colors.black.withOpacity(0.0)
                                        ]),
                                  ),
                                ),
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                            // Ink.image(
                            //   height: 180,
                            //   image: NetworkImage(
                            //     employeeDataList[index].imgurl,
                            //   ),
                            //   fit: BoxFit.cover,
                            // ),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                employeeDataList[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30)),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.access_time_outlined,
                                          size: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      TextSpan(
                                          text: ' 50-70 мин',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15.0),
                                padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30)),
                                child: RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    employeeDataList[index].minorder != null
                                        ? TextSpan(
                                            text: ' от ' +
                                                employeeDataList[index]
                                                    .minorder
                                                    .toString() +
                                                ' \u{20bd}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87))
                                        : TextSpan(
                                            text: ' от 0 \u{20bd}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87)),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // _resto() {
  //   StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection('restourant')
  //         .orderBy('name', descending: false)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return Center(child: new Text('Loading...'));

  //       final List<DocumentSnapshot> documents = snapshot.data.documents;
  //       final List<EmployeeData> employeeDataList =
  //           documents.map((snapshot) => EmployeeData.from(snapshot)).toList();
  //       // now u can access each document by simply specifying its number
  //       // u can also use list view to display every one of them
  //       return ListView.builder(
  //         itemCount: documents.length,
  //         itemBuilder: (context, int index) => ListTile(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) =>
  //                     DetailPage(employeedata: employeeDataList[index]),
  //               ),
  //             );
  //           },
  //           title: Text(employeeDataList[index].name),
  //           subtitle: Text(
  //             employeeDataList[index].idrest,
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

// class Resto extends StatelessWidget {
//   const Resto({Key key, this.name, this.idrest}) : super(key: key);
//   final String name;
//   final String idrest;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance
//           .collection('restourant')
//           .orderBy('name', descending: false)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return Center(child: new Text('Loading...'));

//         final List<DocumentSnapshot> documents = snapshot.data.documents;
//         final List<EmployeeData> employeeDataList =
//             documents.map((snapshot) => EmployeeData.from(snapshot)).toList();
//         // now u can access each document by simply specifying its number
//         // u can also use list view to display every one of them
//         return ListView.builder(
//           itemCount: documents.length,
//           itemBuilder: (context, int index) => ListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailPage(employeedata: employeeDataList[index]),
//                 ),
//               );
//             },
//             title: Text(employeeDataList[index].name),
//             subtitle: Text(
//               employeeDataList[index].idrest,
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

}

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:foodex/items/models/items.dart';

// import 'items_detail.dart';

// class ItemList extends StatelessWidget {
//   const ItemList({Key key, this.title, this.idrest}) : super(key: key);
//   final String title;
//   final String idrest;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance
//             .collection('items')
//             .orderBy('title', descending: false)
//             // .where('idrest', isEqualTo: valzz)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) return new Text('Loading...');
//           return new ListView(
//             children: snapshot.data.documents.map((DocumentSnapshot document) {
//               return new ListTile(
//                 onTap: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => ExPage()),
//                   // );
//                 },
//                 title: new Text(
//                   document['title'],
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: new Text(
//                   document['idrest'].toString(),
//                   style: TextStyle(color: Colors.purple),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
