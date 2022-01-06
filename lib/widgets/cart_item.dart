import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final String id;
  final String fashionId;
  final String name;
  final double price;
  final int quantity;

  CardItem({
    required this.id,
    required this.fashionId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CartProvider>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
        alignment: Alignment.centerRight,
        color: Colors.redAccent,
        padding: const EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dir) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    'You are about to remove this piece !',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  content: const Text(
                    'Are you sure you want to remove this piece from the cart',
                    style: TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ],
                ));
      },
      onDismissed: (dir) {
        model.deleteCartItem(fashionId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: secondColor,
              radius: 30,
              child: Text(
                '\$$price',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            subtitle: Text(
              'Total Price is \$${price * quantity}',
              style: const TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            trailing: Text(
              '$quantity piece',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
