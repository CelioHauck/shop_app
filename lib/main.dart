import 'package:flutter/material.dart';
import 'package:shop_app/infra/http_service.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/product_detail_screen.dart';

import 'package:provider/provider.dart';
import './providers/products_provider.dart';
import 'screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

final client = http.Client();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //TODO: Isso tá ruim demais mas é só para teste :D
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            service: HttpService(
              client: client,
              relativePath: '/accounts:',
              fullPath: 'https://identitytoolkit.googleapis.com/v1',
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(
            service: HttpService(
              client: client,
              relativePath: '/products',
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(
            service: HttpService(
              client: client,
              relativePath: '/orders',
            ),
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.purple,
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.purple,
              secondary: Colors.deepOrange,
            ),
          ),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            UserProductsScreen.routeName: (context) =>
                const UserProductsScreen(),
            EditproductScreen.routeName: (context) => const EditproductScreen(),
          },
          home:
              auth.isAuth ? const ProductsOverviewScreen() : const AuthScreen(),
        ),
      ),
    );
  }
}
