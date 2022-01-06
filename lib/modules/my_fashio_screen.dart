import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/edit_my_fashion_screen.dart';
import 'package:fashion/providers/authentication_provider.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:fashion/widgets/my_fashion_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFashionScreen extends StatelessWidget {
  static const routeName = '/My Fashion';
  Future<void> refreshHomePage(BuildContext context) async {
    await Provider.of<FashionProvider>(context, listen: false).getAllFashions();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FashionProvider>(context);
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
          backgroundColor: secondColor,
          title: const Text(
            'My Fashion',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditMyFashionScreen.routeName);
                },
                icon: const Icon(
                  Icons.add,
                )),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
                icon: const Icon(Icons.logout)),
          ]),
      body: RefreshIndicator(
        onRefresh: () => refreshHomePage(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (context, i) => MyFashionItem(
              id: model.piece[i].id!,
              name: model.piece[i].name,
              image: model.piece[i].image,
            ),
            itemCount: model.piece.length,
          ),
        ),
      ),
    );
  }
}
