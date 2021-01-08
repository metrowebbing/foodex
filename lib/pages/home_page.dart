import '../domain/user.dart';
import '../services/auth.dart';

import '../models/Product.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/catalog.dart';
import '../widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List categoryList = [
    "Бургеры",
    "Шашлык",
    "Суши",
    "Рыба",
  ];

  var selectedIndex = 0;

  Widget _category() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25.0),
      height: 35.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePage(value)));
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    boxShadow: selectedIndex == index
                        ? [
                            BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 30.0,
                                spreadRadius: -12.0,
                                offset: Offset(0, 12))
                          ]
                        : null,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: Text(
                    categoryList[index],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build HomePage');

    // final productData = Provider.of<ProductDataProvider>(context);
    // *Для версии > 4.1.0
    final productData = context.watch<ProductDataProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.sort, color: Colors.deepOrange),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          'Пили-Ели',
          style: TextStyle(color: Colors.orange[800]),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: Colors.deepOrange),
              onPressed: null)
        ],
      ),
      drawer: StreamProvider<User>.value(
        value: AuthService().currentUser,
        child: DrawerPage(),
      ),
      body: SafeArea(
        child: Container(
            height: MediaQuery.of(context).size.height - 85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                )),
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 292,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productData.items.length,
                      itemBuilder: (context, int index) =>
                          ChangeNotifierProvider.value(
                            value: productData.items[index],
                            child: ItemCard(),
                          )

                      // ItemCard(product: productData.items[index]),

                      ),
                ),
                Container(
                  child: Text('Категории',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.grey[800])),
                ),
                _category(),
                ...productData.items.map((value) {
                  return CatalogListTile(imgUrl: value.imgUrl);
                }).toList(),
              ],
            )),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
