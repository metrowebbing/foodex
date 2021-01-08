import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/Orders.dart';

import '../models/Cart.dart';
import '../widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final cartData = Provider.of<CartDataProvider>(context);
    final cartData = context.watch<CartDataProvider>();

    var minprice = 500;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 3,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
            color: Colors.black87,
          ),
          title: Text(
            'Корзина',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: cartData.cartItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.receipt_long,
                      size: 150,
                      color: Colors.grey,
                    ),
                    Text(
                      'Корзина пуста',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : Column(
                children: <Widget>[
                  Expanded(child: CartItemList(cartData: cartData)),
                  //! - Доставка
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Товаров на сумму:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(cartData.totalAmount.toStringAsFixed(0) + ' руб.'),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Доставка:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        cartData.totalAmount < minprice
                            ? Text('100 руб.')
                            : Text('0 руб.'),
                      ],
                    ),
                  ),
                  //! - Доставка
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Итого: ' +
                              cartData.totalAmount.toStringAsFixed(2) +
                              ' р.',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        CheckoutButton(
                          cart: cartData,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ));
  }
}

class CheckoutButton extends StatefulWidget {
  final CartDataProvider cart;

  const CheckoutButton({@required this.cart});

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: Text('Заказать', style: TextStyle(color: Colors.white)),
      onPressed: widget.cart.totalAmount <= 0
          ? null
          : () async {
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.cartItems.values.toList(),
                  widget.cart.totalAmount);
              widget.cart.clear();
            },
    );
  }
}
