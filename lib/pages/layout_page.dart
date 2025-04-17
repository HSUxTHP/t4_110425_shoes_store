import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'detail_page.dart';
import 'home_page.dart';

class LayoutPage extends StatefulWidget {
  LayoutPage ({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();


  List pages = [
    HomePage(),
    CartPage(),
    // DetailPage(shoe: null,),
  ];

  int _selectedIndex = 0;
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Layout Page'),
      // ),
      body: widget.pages[widget._selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: widget._selectedIndex,
        onTap: (index) {
          setState(() {
            widget._selectedIndex = index;
          });
        },
      ),
    );
  }
}
