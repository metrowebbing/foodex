import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodex/models/Cart.dart';
import 'package:foodex/pages/cart_page.dart';
import 'package:foodex/pages/catalog_products_item.dart';
import 'package:foodex/widgets/bottom_bar.dart';
import 'animator.dart';
import 'models/items.dart';
import 'models/resto.dart';
import 'package:provider/provider.dart';

String _restID;

class RestoDetail extends StatefulWidget {
  // Declare a field that holds the Todo.
  final EmployeeData employeedata;

  // In the constructor, require a Todo.
  RestoDetail({Key key, @required this.employeedata}) : super(key: key);

  @override
  _RestoDetailState createState() => _RestoDetailState();
}

class _RestoDetailState extends State<RestoDetail> {
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.employeedata.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: Text('опции заведения ' + widget.employeedata.name)),
            ),
            Container(margin: EdgeInsets.symmetric(vertical: 15.0), height: 35, child: _tabs()),
            // Expanded(child: HiPage()),
            Expanded(child: _listing()),
            BottomBar(),
          ],
        ));
  }

  String categoryId;
  var selectedIndex = 'Все';

  Widget _tabs() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('category').where('idrest', isEqualTo: widget.employeedata.idrest).orderBy('por', descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: new CircularProgressIndicator());
        return Container(
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return GestureDetector(
                onTap: () {
                  print(document['title']);
                  setState(() {
                    selectedIndex = document['title'];
                    categoryId = document['id'];
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: selectedIndex == document['title'] ? Theme.of(context).primaryColor : Colors.grey[200],
                        boxShadow: selectedIndex == document['title']
                            ? [BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 30.0, spreadRadius: -15.0, offset: Offset(0, 12))]
                            : null,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Center(
                      child: Text(
                        document['title'],
                        style: TextStyle(fontWeight: FontWeight.bold, color: selectedIndex == document['title'] ? Colors.white : Colors.black),
                      ),
                    )),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // String categoryName;

  // _tabs() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection('category')
  //         .where('idrest', isEqualTo: widget.employeedata.idrest)
  //         .orderBy('title', descending: false)
  //         .snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (!snapshot.hasData)
  //         return Center(child: new CircularProgressIndicator());
  //       return ListView(
  //         scrollDirection: Axis.horizontal,
  //         physics: BouncingScrollPhysics(),
  //         children: snapshot.data.documents.map((DocumentSnapshot document) {
  //           return InkWell(
  //             onTap: () {
  //               print(document['title']);
  //               setState(() {
  //                 categoryName = document['title'];
  //               });
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(20.0),
  //               child: Text(document['title']),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }

  _listing() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .orderBy('title', descending: false)
          .where('idrest', isEqualTo: widget.employeedata.idrest)
          .where('category', isEqualTo: categoryId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: new CircularProgressIndicator());
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: snapshot.data.documents.map((DocumentSnapshot document) {
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
                                boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.black12)]),
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
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      // Container(
                                      //   child: Text(document['subtitle']),
                                      // ),
                                      Container(
                                        child: Text('Цена продукта: ' + document['price'].toString() + '\n' + document['idrest']),
                                      ),
                                    ],
                                  ),
                                ),
                                context.watch<CartDataProvider>().cartItems.containsKey(document['id'])
                                    ? Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            print("Test amb");
                                            print(document['idrest']);
                                            print(document['title']);
                                            // navigateToDetail(post);

                                            // showModalBottomSheet(
                                            //     backgroundColor:
                                            //         Colors.transparent,
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return Container(
                                            //         padding:
                                            //             EdgeInsets.all(20.0),
                                            //         decoration: BoxDecoration(
                                            //             color: Colors.white,
                                            //             borderRadius:
                                            //                 BorderRadius.only(
                                            //               topRight:
                                            //                   Radius.circular(
                                            //                       15),
                                            //               topLeft:
                                            //                   Radius.circular(
                                            //                       15),
                                            //             ),
                                            //             boxShadow: [
                                            //               BoxShadow(
                                            //                   blurRadius: 1,
                                            //                   spreadRadius: 1,
                                            //                   color: Colors
                                            //                       .black12)
                                            //             ]),
                                            //         height:
                                            //             MediaQuery.of(context)
                                            //                     .size
                                            //                     .height *
                                            //                 .60,
                                            //         child: Column(
                                            //           children: [
                                            //             Text(document[
                                            //                 'subtitle']),
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
                                            print("Test gre");
                                            var _id = document['id'].toString();
                                            print(_id);
                                            print(document['idrest']);
                                            print(document['title']);
                                            var _ord = context.read<CartDataProvider>();
                                            print(_ord.cartItems.length);
                                            if (_ord.cartItemsCount == 0) {
                                              _restID = document['idrest'];
                                            }
                                            // print(_ord.cartItems[0].idrest);
                                            if (document['idrest'] == _restID) {
                                              context.read<CartDataProvider>().addItem(
                                                    productId: document['id'],
                                                    imgUrl: document['imgUrl'],
                                                    idrest: document['idrest'],
                                                    title: document['title'],
                                                    price: document['price'],
                                                  );
                                            } else {
                                              print('Another rest');
                                            }

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
            }).toList(),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';

// import 'models/items.dart';

// class DetailPage extends StatelessWidget {
//   // Declare a field that holds the Todo.
//   final EmployeeData employeedata;

//   // In the constructor, require a Todo.
//   DetailPage({Key key, @required this.employeedata}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Use the Todo to create the UI.
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(employeedata.name),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text('id - ' + employeedata.idrest),
//       ),
//     );
//   }
// }

// class ItemListing extends StatelessWidget {
//   // Declare a field that holds the Todo.
//   final ItemsData itemsdata;

//   // In the constructor, require a Todo.
//   ItemListing({Key key, @required this.itemsdata}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//         delegate: SliverChildListDelegate([
//       ListTile(
//         title: Text('hi'),
//       ),
//     ]));
//   }
// }
