import 'package:fashion/modules/edit_my_fashion_screen.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFashionItem extends StatelessWidget {
  final String id;
  final String name;
  final String image;

  MyFashionItem({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FashionProvider>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image),
      ),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditMyFashionScreen.routeName, arguments: id);
                },
                icon: const Icon(Icons.edit, color: Colors.black)),
            IconButton(
                onPressed: () {
                  model.deleteFashion(id);
                },
                icon: const Icon(Icons.delete, color: Colors.red))
          ],
        ),
      ),
    );
  }
}
