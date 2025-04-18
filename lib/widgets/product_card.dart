import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/shoe_model.dart';
import '../providers/cart_provider.dart';

class ProductCart extends StatefulWidget {
  ProductCart({super.key, required this.shoe});

  final Shoe shoe;


  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.shoe.imageUrl[0],
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.shoe.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '\$${widget.shoe.price}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.shoe.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            //dateSell is later than now
            if (widget.shoe.dateSell != null &&
                widget.shoe.dateSell!.isAfter(DateTime.now()))
              Text(
                'Available until: ${widget.shoe.dateSell!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    print("Detail: ${widget.shoe.name}");
                    Navigator.pushNamed(context, '/detail', arguments: widget.shoe);
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  label: const Text('Detail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ShoeInCart newShoe = ShoeInCart(
                      id: widget.shoe.id,
                      name: widget.shoe.name,
                      price: widget.shoe.price,
                      imageUrl: widget.shoe.imageUrl,
                      description: widget.shoe.description,
                      size: widget.shoe.size,
                      inStock: widget.shoe.inStock,
                      maxBuy: widget.shoe.maxBuy,
                      dateSell: widget.shoe.dateSell,
                    );

                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    int existingQty = cartProvider.cartItems
                        .where((item) => item.id == newShoe.id)
                        .fold(0, (sum, item) => sum + item.quantity);

                    // kiểm tra trước khi thêm
                    if (existingQty >= newShoe.maxBuy) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Exceeded purchase limit for this product.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (existingQty >= newShoe.inStock) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Not enough stock'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    print("Add to cart: ${newShoe.name}");
                    cartProvider.addToCart(context, newShoe);

                    if (widget.shoe.dateSell!.isBefore(DateTime.now())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.shoe.name} has been added to cart!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  onHover: (isHovering) {
                    setState(() {
                      isHovering = isHovering;
                    });
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: const Text('Add to cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
