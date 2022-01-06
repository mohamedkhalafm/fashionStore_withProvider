import 'package:fashion/models/cart_model.dart';
import 'package:fashion/widgets/cart_item.dart';
import 'package:fashion/models/order_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CardModel> fashionCart, double total) {
    _orders.insert(
        0,
        OrderModel(
            id: DateTime.now().toString(),
            amount: total,
            dateTime: DateTime.now(),
            fashions: fashionCart));
    notifyListeners();
  }
}
