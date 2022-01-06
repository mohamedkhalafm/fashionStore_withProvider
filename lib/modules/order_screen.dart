import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/providers/order_provider.dart';
import 'package:fashion/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<OrderProvider>(context);
    return Scaffold(
        backgroundColor: firstColor,
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) => OrderItem(model.orders[index]),
            itemCount: model.orders.length));
  }
}
