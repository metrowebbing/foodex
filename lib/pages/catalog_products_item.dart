import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodex/items/animator.dart';
import 'package:foodex/models/Cart.dart';

import 'package:provider/provider.dart';

import 'item_page.dart';

class HiPage extends StatelessWidget {
  const HiPage(
      {Key key, this.id, this.title, this.price, this.category, this.imgUrl})
      : super(key: key);

  final String id;
  final String title;
  final String category;
  final String imgUrl;
  final String price;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    navigateToDetail(DocumentSnapshot post) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemPage(
                    productId: document['id'],
                  )));
    }

    return WidgetANimator(
      Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Container(
          height: 120,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 2),
                  width: MediaQuery.of(context).size.width * .59,
                  height: 100,
                  // padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: Colors.black12)
                      ]),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                document['title'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            // Container(
                            //   child: Text(document['subtitle']),
                            // ),
                            Container(
                              child: Text('Цена: ' +
                                  document['price'].toString() +
                                  '\n' +
                                  document['idrest']),
                            ),
                          ],
                        ),
                      ),
                      context
                              .watch<CartDataProvider>()
                              .cartItems
                              .containsKey(document['id'])
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  print(document['title']);
                                  // navigateToDetail(post);

                                  // showModalBottomSheet(
                                  //     backgroundColor: Colors.transparent,
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Container(
                                  //         padding: EdgeInsets.all(20.0),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.only(
                                  //               topRight: Radius.circular(15),
                                  //               topLeft: Radius.circular(15),
                                  //             ),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                   blurRadius: 1,
                                  //                   spreadRadius: 1,
                                  //                   color: Colors.black12)
                                  //             ]),
                                  //         height: MediaQuery.of(context).size.height *
                                  //             .60,
                                  //         child: Column(
                                  //           children: [
                                  //             Text(document['subtitle']),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     });
                                },
                                child: Container(
                                  height: 50,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  print(document['title']);
                                  context.read<CartDataProvider>().addItem(
                                        productId: document['id'],
                                        imgUrl: document['imgUrl'],
                                        title: document['title'],
                                        price: document['price'],
                                      );

                                  // showModalBottomSheet(
                                  //     backgroundColor: Colors.transparent,
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Container(
                                  //         padding: EdgeInsets.all(20.0),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             borderRadius: BorderRadius.only(
                                  //               topRight: Radius.circular(15),
                                  //               topLeft: Radius.circular(15),
                                  //             ),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                   blurRadius: 1,
                                  //                   spreadRadius: 1,
                                  //                   color: Colors.black12)
                                  //             ]),
                                  //         height: MediaQuery.of(context).size.height *
                                  //             .60,
                                  //         child: Column(
                                  //           children: [
                                  //             Text(document['subtitle']),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     });
                                },
                                child: Container(
                                  height: 50,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CachedNetworkImage(
                  imageUrl: document['imgUrl'],
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width * .33,
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.bottomRight,
                    //         colors: [
                    //           Colors.black.withOpacity(0.6),
                    //           Colors.black.withOpacity(0.0)
                    //         ]),
                    //   ),
                    // ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.black12,
                          )
                        ]),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
          ),
          // child: Text(document['title']),
          // subtitle:
          //     Text(document['idrest'] + '\n' + document['category']),
        ),
      ),
    );
  }

// // !- knopka
//                       context
//                               .watch<CartDataProvider>()
//                               .cartItems
//                               .containsKey(document['id'])
//                           ? MaterialButton(
//                               color: Color(0xFFCCFF90),
//                               child: Text('К корзине'),
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => CartPage(),
//                                 ));
//                               })
//                           : MaterialButton(
//                               color: Theme.of(context).primaryColor,
//                               child: Text('Купить'),
//                               onPressed: () {
//                                 context.read<CartDataProvider>().addItem(
//                                       productId: document['id'],
//                                       imgUrl: document['imgUrl'],
//                                       title: document['title'],
//                                       price: document['price'],
//                                     );
//                               },
//                             ),

//                       // !- knopka

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Заголовок'),
//       // ),
//       body: StreamBuilder(
//           stream: Firestore.instance
//               .collection('items')
//               .orderBy("title", descending: false)
//               // .where("idrest")
//               .snapshots(),
//           builder: (context, snapshots) {
//             if (!snapshots.hasData) return const Text('Loading...');
//             return GroupedListView<dynamic, String>(
//               elements: snapshots.data.documents,
//               groupBy: (element) => element['category'],
//               groupSeparatorBuilder: (String value) => Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   value,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // groupSeparatorBuilder: (String categoryByValue) => Text(categoryByValue),
//               itemBuilder: (context, index) =>
//                   _buildListItem(context, snapshots.data.documents[index]),
//               order: GroupedListOrder.ASC,
//             );
//           }),
//       // bottomNavigationBar: BottomBar(),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Заголовок'),
      // ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('items')
              .orderBy("title", descending: false)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) return const Text('Loading...');
            return Container(
              margin: EdgeInsets.only(right: 12, left: 12),
              child: ListView.builder(
                // itemExtent: 70,
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshots.data.documents[index]),
              ),
            );
          }),
      // bottomNavigationBar: BottomBar(),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Hi'),
    );
  }
}
