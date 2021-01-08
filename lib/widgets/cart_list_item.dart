import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cart.dart';

import 'cart_item.dart';

class CartItemList extends StatelessWidget {
  final cartData;

  CartItemList({Key key, this.cartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          // padding: const EdgeInsets.all(0),
          itemCount: cartData.cartItemsCount,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(cartData.cartItems.keys.toList()[index]),
              background: Container(
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.redAccent),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.only(right: 0.0),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) =>
                  Provider.of<CartDataProvider>(context, listen: false)
                      .deleteItem(cartData.cartItems.keys.toList()[index]),
              child: CartItem(
                cartData: cartData,
                index: index,
              ),
            );
          }),
    );
  }
}
