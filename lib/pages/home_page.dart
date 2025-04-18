import 'package:flutter/material.dart';
import '../models/shoe_model.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Shoe> data = [
    Shoe(
      id: '1',
      name: 'Nike Air Max 270 date3004',
      imageUrl: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 150.0,
      description: 'A stylish and comfortable sneaker for everyday wear.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-30'),
    ),
    Shoe(
      id: '2',
      name: 'Adidas Ultraboost 21 maxBuy10',
      imageUrl: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 180.0,
      description: 'High-performance running shoes with great cushioning.',
      size: '10',
      inStock: 200,
      maxBuy: 10,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '3',
      name: 'Puma RS-X inStock1',
      imageUrl: [
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
          'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 120.0,
      description: 'Retro-inspired sneakers with a bold design.',
      size: '10',
      inStock: 1,
      maxBuy: 10,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '4',
      name: 'New Balance 990v5',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],      price: 175.0,
      description: 'Classic running shoes with a premium feel.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '5',
      name: 'Asics Gel-Kayano 27',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 160.0,
      description: 'Supportive running shoes for long-distance runners.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '6',
      name: 'Reebok Classic Leather',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 85.0,
      description: 'Timeless sneakers with a clean and simple design.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '7',
      name: 'Vans Old Skool',
      imageUrl: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 70.0,
      description: 'Iconic skate shoes with a classic look.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '8',
      name: 'Converse Chuck Taylor All Star',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 60.0,
      description: 'Classic canvas sneakers with a timeless design.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '9',
      name: 'Under Armour HOVR Phantom 2',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 140.0,
      description: 'High-tech running shoes with great energy return.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
    Shoe(
      id: '10',
      name: 'Hoka One One Bondi 7',
      imageUrl: [
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://img.freepik.com/free-psd/floating-white-sneaker-minimalist-shoe-design_191095-80028.jpg?semt=ais_hybrid&w=740',
      'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-thumbnail.png'
      ],
      price: 160.0,
      description: 'Maximum cushioning for a comfortable ride.',
      size: '10',
      inStock: 5,
      maxBuy: 2,
      dateSell: DateTime.parse('2025-04-11'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Page'),
          automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
      itemCount: data.length,
        itemBuilder: (context, index) {
          return ProductCart(
            shoe: data[index],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //navigate to cart page
      //   },
      //   tooltip: 'Add to Cart',
      //   child: const Icon(Icons.add_shopping_cart),
      // ),
    );
  }
}
