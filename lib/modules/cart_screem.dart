import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/order_screen.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:fashion/providers/order_provider.dart';
import 'package:fashion/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CartProvider>(context);
    final modelProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(14),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Text('Total',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Chip(
                          label: Text('\$ ${model.totaPrice}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)))),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        modelProvider.addOrder(
                            model.items.values.toList(), model.totaPrice);
                        model.clear();
                        Navigator.of(context).pushNamed(OrderScreen.routeName);
                      },
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                            color: secondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'SWIPE TO DELETE',
                      style: TextStyle(
                          color: secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Spacer(),
                    Image(
                      image: NetworkImage(
                        'https://www.nicepng.com/png/full/339-3390245_one-swipe-left-comments-swipe-left-png-icon.png',
                      ),
                      height: 80,
                      width: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CardItem(
                id: model.items.values.toList()[index].id,
                fashionId: model.items.keys.toList()[index],
                name: model.items.values.toList()[index].name,
                price: model.items.values.toList()[index].price,
                quantity: model.items.values.toList()[index].quantity,
              ),
              itemCount: model.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
