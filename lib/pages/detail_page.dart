import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shoe_model.dart';
import '../providers/cart_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.shoe});

  final Shoe shoe;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text('Detail Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      shoe.imageUrl[currentIndex],
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_back),
                      //   onPressed: () {
                      //     if (currentIndex > 0) {
                      //       setState(() {
                      //         currentIndex--;
                      //       });
                      //     }
                      //   },
                      // ),
                      // const SizedBox(width: 16),
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_forward),
                      //   onPressed: () {
                      //     if (currentIndex < shoe.imageUrl.length - 1) {
                      //       setState(() {
                      //         currentIndex++;
                      //       });
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(shoe.imageUrl.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentIndex == index ? Colors.teal : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                shoe.imageUrl[index],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              shoe.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'ID: ${shoe.id}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Text(
              '\$${shoe.price}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              shoe.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Size: ${shoe.size}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'In Stock: ${shoe.inStock}',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Max Buy: ${shoe.maxBuy}',
              style: const TextStyle(fontSize: 15),
            ),
            if (shoe.dateSell != null)
              Text(
                'Date Sell: ${shoe.dateSell!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ShoeInCart newShoe = ShoeInCart(
                      id: shoe.id,
                      name: shoe.name,
                      price: shoe.price,
                      imageUrl: shoe.imageUrl,
                      description: shoe.description,
                      size: shoe.size,
                      inStock: shoe.inStock,
                      maxBuy: shoe.maxBuy,
                      dateSell: shoe.dateSell,
                    );

                    final cartProvider = Provider.of<CartProvider>(context, listen: false);

                    // Kiểm tra số lượng đã có trong giỏ hàng
                    int existingQty = cartProvider.cartItems
                        .where((item) => item.id == newShoe.id)
                        .fold(0, (sum, item) => sum + item.quantity);

                    // Kiểm tra vượt quá giới hạn maxBuy
                    if (existingQty >= newShoe.maxBuy) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Exceeded purchase limit for this product.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Kiểm tra nếu tồn kho không đủ
                    if (existingQty >= newShoe.inStock) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Not enough stock in stock.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Kiểm tra ngày bán của sản phẩm
                    if (shoe.dateSell!.isBefore(DateTime.now())) {
                      print("Add to cart: ${newShoe.name}");
                      cartProvider.addToCart(context, newShoe);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${shoe.name} added to cart!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item cannot be added because the dateSell is less than today.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (!(shoe.dateSell!.isBefore(DateTime.now()))) {
                      print('Item cannot be added because the dateSell is less than today.');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Item cannot be added because the dateSell is less than today.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                    else {
                      ShoeInCart newShoe = ShoeInCart(
                        id: shoe.id,
                        name: shoe.name,
                        price: shoe.price,
                        imageUrl: shoe.imageUrl,
                        description: shoe.description,
                        size: shoe.size,
                        inStock: shoe.inStock,
                        maxBuy: shoe.maxBuy,
                        dateSell: shoe.dateSell,
                      );
                      print("Add to cart: ${newShoe.name}");
                      Provider
                          .of<CartProvider>(context, listen: false)
                          .addToCart(context, newShoe);
                      print("Buy now: ${shoe.name}");
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/cart');
                    }
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Buy now"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
