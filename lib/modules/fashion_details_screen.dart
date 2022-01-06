import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/order_screen.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:fashion/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FashionDetailsScreen extends StatelessWidget {
  static const routePass = 'fashion_details';

  @override
  Widget build(BuildContext context) {
    final fashionId = ModalRoute.of(context)!.settings.arguments as String;
    final model = Provider.of<FashionProvider>(context)
        .piece
        .firstWhere((element) => element.id == fashionId);
    final modelCart = Provider.of<CartProvider>(context);
    final modelProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: firstColor,
      // appBar: AppBar(
      //   title: Text(model.name),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                width: double.infinity,
                height: 430,
                child: Stack(children: [
                  Hero(
                    tag: model.id!,
                    child: Image(
                      image: NetworkImage(model.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 430,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Color',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.black)),
                            const SizedBox(
                              height: 7.0,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: model.color,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                            ),
                            const SizedBox(
                              height: 7.0,
                            ),
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.brown,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Size',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white)),
                            SizedBox(
                              height: 7.0,
                            ),
                            CircleAvatar(
                              radius: 30,
                              child: Text(
                                'L',
                                //model.size.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: secondColor,
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            CircleAvatar(
                                radius: 30,
                                child: Text('M',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: secondColor),
                            SizedBox(
                              height: 7.0,
                            ),
                            CircleAvatar(
                                radius: 30,
                                child: Text('S',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: secondColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34)),
                    color: secondColor),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 230, left: 230, top: 10),
                      child: Container(
                        width: double.infinity,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('More Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(model.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text('${model.price} \$',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text('Size',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Text('Color',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Text('Discount',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Text('Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text('L',
                                //model.size.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: model.color,
                          ),
                        ),
                        Expanded(
                          child: Text('${model.discount} \$ ,',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Text('${model.price - model.discount} \$ ,',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 50,
                      width: 190,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {
                          modelProvider.addOrder(
                              modelCart.items.values.toList(),
                              modelCart.totaPrice);
                          modelCart.clear();
                          Navigator.of(context)
                              .pushNamed(OrderScreen.routeName);
                        },
                        child: const Text('Add to Chart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
