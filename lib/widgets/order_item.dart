import 'dart:math';

import 'package:fashion/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final OrderModel order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Cost : ${widget.order.amount} \$',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            subtitle: Text(
              DateFormat('dd MM yyyy').format(widget.order.dateTime),
              style: const TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: expanded
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more)),
          ),
          if(expanded)
          Container(
            height: min(widget.order.fashions.length* 20.0 + 100 , 150.0),
            child: ListView(
              children: widget.order.fashions.map((element) =>Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element.name,style: const TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 13),),
                    Text('${element.quantity} piece  \$${element.price}',style: const TextStyle(
                    color: Colors.black,
                   // fontWeight: FontWeight.bold,
                    fontSize: 13),)
                  ],
                ),
              )).toList(),
            ),
          )
        ],
      ),
    );
  }
}
