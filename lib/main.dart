import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_110425_shoes_store/pages/cart_page.dart';
import 'package:t4_110425_shoes_store/pages/detail_page.dart';
import 'package:t4_110425_shoes_store/pages/layout_page.dart';
import 'package:t4_110425_shoes_store/providers/cart_provider.dart';

import 'models/shoe_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoes Store',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        ),
        home: LayoutPage(),
        routes: {
          '/detail': (context) => DetailPage(
                shoe: ModalRoute.of(context)!.settings.arguments as Shoe,
              ),
          '/cart': (context) => const CartPage(
          ),
        },
      ),
    );
  }
}
