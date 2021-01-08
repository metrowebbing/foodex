import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodex/items/animator.dart';
import 'models/resto.dart';

class StraemItemsList extends StatelessWidget {
  const StraemItemsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .orderBy('category', descending: false)
          // .where('category', isEqualTo: categoryName)
          // .where('idrest', isEqualTo: widget.employeedata.idrest)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: new CircularProgressIndicator());
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
                            width: MediaQuery.of(context).size.width * .58,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          document['title'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      // Container(
                                      //   child: Text(document['subtitle']),
                                      // ),
                                      Container(
                                        child: Text('Цена: ' +
                                            document['price'].toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        print(document['title']);
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
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CachedNetworkImage(
                            imageUrl: document['imgUrl'],
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * .35,
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
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
