import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/cart_screem.dart';
import 'package:fashion/modules/edit_my_fashion_screen.dart';
import 'package:fashion/modules/fashion_details_screen.dart';
import 'package:fashion/modules/home_screen.dart';
import 'package:fashion/modules/login_screen.dart';
import 'package:fashion/modules/my_fashio_screen.dart';
import 'package:fashion/modules/order_screen.dart';
import 'package:fashion/modules/register_screen.dart';
import 'package:fashion/providers/authentication_provider.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:fashion/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => AuthProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, FashionProvider>(
            create: (context) => FashionProvider('', [], ''),
            update: (_, auth, previousFashion) => FashionProvider(
                auth.token!,
                previousFashion == null ? [] : previousFashion.piece,
                auth.userId),

            //create: (BuildContext context, auth,previousFashion) => FashionProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => OrderProvider(),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                accentColor: thirdColor,
                buttonColor: thirdColor,
                appBarTheme: AppBarTheme(backgroundColor: secondColor)),
            home: auth.isAuth ? HomeScreen() : LoginScreen(),
            routes: {
              HomeScreen.routePass: (context) => HomeScreen(),
              RegisterScreen.routePass: (context) => RegisterScreen(),
              FashionDetailsScreen.routePass: (context) =>
                  FashionDetailsScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              MyFashionScreen.routeName: (context) => MyFashionScreen(),
              EditMyFashionScreen.routeName: (context) => EditMyFashionScreen(),
            },
          ),
        ));
  }
}
