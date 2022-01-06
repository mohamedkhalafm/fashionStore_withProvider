import 'package:fashion/component/reusable_components.dart';

import 'package:fashion/models/fashion_model.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditMyFashionScreen extends StatefulWidget {
  static const routeName = '\edit-fadhion';

  @override
  _EditMyFashionState createState() => _EditMyFashionState();
}

class _EditMyFashionState extends State<EditMyFashionScreen> {
  final nameController = FocusNode();
  final priceController = FocusNode();
  final discountController = FocusNode();
  final imageController = TextEditingController();
  final imageUrlFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var editFashion = FashionModel(
    //id: '0',
    name: '',
    price: 0,
    discount: 0,
    image: '',
    //isInCart: true,
    //size: '',
    //color: firstColor,
    //isInFavorites: false
  );
  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImage);
    super.initState();
  }

  var isInite = true;
  var isLoading = false;

  var inaiteValue = {
    'name': '',
    'price': '',
    'discount': '',
    'image': '',
  };

  @override
  void didChangeDependencies() {
    if (isInite) {
      final fashionId = ModalRoute.of(context)!.settings.arguments as String;
      if (fashionId != null) {
        editFashion = Provider.of<FashionProvider>(context, listen: false)
            .findById(fashionId);
        inaiteValue = {
          'name': editFashion.name,
          'price': editFashion.price.toString(),
          'discount': editFashion.discount.toString(),
          //'image': editFashion.image,
        };
        imageController.text = editFashion.image;
      }
    }
    isInite = false;
    super.didChangeDependencies();
  }

  void updateImage() {
    if (!imageUrlFocusNode.hasFocus) {
      if (!imageController.text.isEmpty ||
          (!imageController.text.startsWith('http')) &&
              !imageController.text.startsWith('https')) return;

      setState(() {});
    }
  }

  Future<void> saveChanges() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    if (editFashion.id != null) {
      await Provider.of<FashionProvider>(context, listen: false)
          .updateFashion(editFashion.id!, editFashion);
    } else {
      try {
        await Provider.of<FashionProvider>(context, listen: false)
            .addFashion(editFashion);
      } catch (e) {
        print(e);
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                    title: const Text('ERROR!'),
                    content: const Text('Something went wrong.'),
                    actions: <Widget>[
                      // ignore: deprecated_member_use
                      FlatButton(
                          child: const Text('Okay'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          })
                    ]));
      }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    imageUrlFocusNode.removeListener(updateImage);
    priceController.dispose();
    discountController.dispose();
    imageController.dispose();
    imageUrlFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        title: const Text('Edit My Fashion'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black54,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        initialValue: inaiteValue['name'],
                        //controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(nameController);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not be empty';
                          }
                          return null;
                        },

                        onSaved: (value) {
                          editFashion = FashionModel(
                              name: value ?? '',
                              price: editFashion.price,
                              discount: editFashion.discount,
                              image: editFashion.image,
                              //isInCart: editFashion.isInCart,
                              //size: editFashion.size,
                              //color: editFashion.color,
                              isInFavorites: editFashion.isInFavorites);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        initialValue: inaiteValue['price'],
                        //controller: priceController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Price'),
                        ),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(priceController);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Price must not be empty';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter Number not text';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Enter Number greater than 0';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          formKey.currentState!.validate();
                          editFashion = FashionModel(
                            //id: editFashion.id,
                            name: editFashion.name,
                            price: double.parse(value!),
                            discount: editFashion.discount,
                            image: editFashion.image,
                            //isInCart: editFashion.isInCart,
                            //size: editFashion.size,
                            //color: editFashion.color,
                            //isInFavorites: editFashion.isInFavorites
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        initialValue: inaiteValue['discount'],
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Discount'),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Discount must not be empty';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter Number not text';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Enter Number greater than 0';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(discountController);
                        },
                        onSaved: (value) {
                          editFashion = FashionModel(
                            //id: editFashion.id,
                            name: editFashion.name,
                            price: editFashion.price,
                            discount: double.parse(value!),
                            image: editFashion.image,
                            // isInCart: editFashion.isInCart,
                            // size: editFashion.size,
                            // color: editFashion.color,
                            // isInFavorites: editFashion.isInFavorites
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 130,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 3, color: Colors.black)),
                          child: Container(
                            child: imageController.text.isEmpty
                                ? const Text('Enter the Image URL')
                                : FittedBox(
                                    child: Image.network(
                                      imageController.text,
                                      width: 130,
                                      height: 100,
                                    ),
                                    fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13))),
                            child: TextFormField(
                              initialValue: inaiteValue['image'],
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(16),
                                  label: Text('URL Image')),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              focusNode: imageUrlFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Name must not be empty';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Enter Valid URL';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                saveChanges();
                              },
                              onSaved: (value) {
                                editFashion = FashionModel(
                                  //id: editFashion.id,
                                  name: editFashion.name,
                                  price: editFashion.price,
                                  discount: editFashion.discount,
                                  image: value ?? '',
                                  // isInCart: editFashion.isInCart,
                                  // size: editFashion.size,
                                  // color: editFashion.color,
                                  // isInFavorites: editFashion.isInFavorites
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveChanges();
        },
        child: const Icon(Icons.save),
        backgroundColor: secondColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
