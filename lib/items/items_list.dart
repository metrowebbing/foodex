import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodex/items/services/getitem.dart';

class ListinItems extends StatefulWidget {
  @override
  _ListinItemsState createState() => _ListinItemsState();
}

class _ListinItemsState extends State<ListinItems> {
  CrudItems crudMethods = new CrudItems();

  Stream itemsStream;

  Widget ItemsList() {
    return SingleChildScrollView(
      child: itemsStream != null
          ? Column(
              children: <Widget>[
                StreamBuilder(
                    stream: itemsStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return Center(child: CircularProgressIndicator());
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ItemsTile(
                                imgUrl: snapshot
                                    .data.documents[index].data['imgUrl'],
                                title: snapshot
                                    .data.documents[index].data['title'],
                                subtitle: snapshot
                                    .data.documents[index].data['subtitle'],
                                price: snapshot
                                    .data.documents[index].data['price']
                                    .toString());
                          });
                    })
              ],
            )
          : Container(
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      // Костыль
      setState(() {
        itemsStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Администратор',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ItemsList(),
      // body: ItemsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// // to get size
// var size = MediaQuery.of(context).size;

// // style
// var cardTextStyle = TextStyle(
//   fontSize: 14,
//   color: Colors.black,
// );

class ItemsTile extends StatelessWidget {
  String imgUrl;
  String title;
  String subtitle;
  String price;

  ItemsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.subtitle,
      @required this.price});
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      ListTile(
        title: Text(title),
      ),
      ListTile(
        title: Text(subtitle),
      ),
    ]));

    // Container(
    //   //width: double.infinity,
    //   margin: EdgeInsets.only(right: 10, left: 10, bottom: 3, top: 20),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.grey[300].withOpacity(0.5),
    //         spreadRadius: 3,
    //         blurRadius: 3,
    //         offset: Offset(0, 3), // changes position of shadow
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       ClipRRect(
    //         borderRadius: BorderRadius.circular(20),
    //         child: CachedNetworkImage(
    //           imageUrl: imgUrl,
    //           placeholder: (context, url) =>
    //               Center(child: CircularProgressIndicator()),
    //           errorWidget: (context, url, error) => Icon(Icons.image),
    //           width: 100,
    //           height: 100,
    //           fit: BoxFit.cover,
    //         ),
    //         // Image(
    //         //   image: NetworkImage(imgUrl),
    //         //   width: 100,
    //         //   height: 100,
    //         //   fit: BoxFit.cover,
    //         // ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(6.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Container(
    //               child: Text(title,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16,
    //                     color: Colors.redAccent,
    //                   )),
    //             ),
    //             Container(child: Text(subtitle)),
    //             SizedBox(
    //               height: 10.0,
    //             ),
    //             Text(price),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
