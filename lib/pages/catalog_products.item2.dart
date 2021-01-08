import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodex/widgets/bottom_bar.dart';
import 'package:async/async.dart';

class HiPage2 extends StatelessWidget {
  const HiPage2({Key key, this.title}) : super(key: key);
  final String title;

  Future getPosts() async {
    var firesore = Firestore.instance;
    QuerySnapshot qn = await firesore.collection("items").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
      ),
      body: Container(
        child: FutureBuilder(
          future: getPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.lenght,
                  itemBuilder: (_, index) {
                    return ListTile(
                        // title: Text(snapshot.data[index].data["title"]),
                        );
                  });
            }
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
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
