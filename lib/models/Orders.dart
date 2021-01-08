import 'package:http/http.dart' as http;
import 'dart:convert';
import './Cart.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<Cart> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<Cart> cartProducts, double total) async {
    final url = 'https://foodex-c0e31.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': DateTime.now().toString(),
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((ex) => {
                      'id': ex.id,
                      'title': ex.title,
                      'number': ex.number,
                      'price': ex.price
                    })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['title'],
              amount: total,
              dateTime: timeStamp,
              products: cartProducts));
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
