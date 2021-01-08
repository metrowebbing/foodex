import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cart.dart';
import '../pages/cart_page.dart';
import '../pages/item_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartDataProvider>(context);
    final cartItems = cartData.cartItems;

    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(0.0),
        // height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(
          //   Radius.circular(20),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 2 + 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cartItems.length,
                itemBuilder: (context, index) => Hero(
                  tag: cartItems.values.toList()[index].imgUrl,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemPage(
                            productId: cartItems.keys.toList()[index],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: cartItems.values.toList()[index].imgUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 4.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(-2, 2),
                                )
                              ],
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 2,
                            bottom: 5,
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                  '${cartItems.values.toList()[index].number}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // height: 50.0,
              width: MediaQuery.of(context).size.width / 2 - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  cartData.totalAmount == 0
                      ? Text('Пусто')
                      : Text(cartData.totalAmount.toStringAsFixed(0) + ' руб'),

                  // Text(cartData.totalAmount.toStringAsFixed(0)),
                  IconButton(
                    icon: Icon(Icons.shopping_bag_outlined,
                        color: Color(0xFF676E79)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
