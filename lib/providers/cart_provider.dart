import 'package:flutter/material.dart';
import 'package:t4_110425_shoes_store/models/shoe_model.dart';


class CartProvider with ChangeNotifier {
  final List<ShoeInCart> _cartItems = [];
  final Set<String> _selectedItemIds = {}; // id của các item được chọn

  List<ShoeInCart> get cartItems => _cartItems;
  Set<String> get selectedItemIds => _selectedItemIds;
  bool get isMultiSelecting => _selectedItemIds.isNotEmpty;

  int get totalItems => _cartItems.length;
  double get totalPrice => _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  int get totalQuantity => _cartItems.fold(0, (total, item) => total + item.quantity);

  void addToCart(BuildContext context, ShoeInCart item) {
    int index = _cartItems.indexWhere((shoe) => shoe.id == item.id);

    if (index != -1) {
      final currentItem = _cartItems[index];
      if (currentItem.quantity < item.maxBuy && currentItem.quantity < item.inStock) {
        currentItem.quantity++;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Notification'),
            content: const Text('Maximum purchase limit reached or out of stock.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      }
    } else {
      if (item.dateSell.isBefore(DateTime.now())) {
        if (item.inStock > 0 && item.maxBuy > 0) {
          _cartItems.add(item);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Notification'),
              content: const Text('Cannot add to cart because out of stock or purchase limit exceeded.'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot add because the sale date has not come yet.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      }
    }

    notifyListeners();
  }


  void decreaseItem(ShoeInCart item) {
    int index = _cartItems.indexWhere((shoe) => shoe.id == item.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void updateQuantity(BuildContext context, ShoeInCart item, int newQuantity) {
    int index = _cartItems.indexWhere((shoe) => shoe.id == item.id);
    if (index != -1) {
      String warning = '';
      int maxAllowed = item.maxBuy < item.inStock ? item.maxBuy : item.inStock;

      if (newQuantity > item.maxBuy && newQuantity > item.inStock) {
        warning =
        'The quantity you selected exceeds the purchase limit (${item.maxBuy}) and existing inventory (${item.inStock}).';
      } else if (newQuantity > item.maxBuy) {
        warning = 'The quantity you selected exceeds the purchase limit (${item.maxBuy}).';
      } else if (newQuantity > item.inStock) {
        warning = 'The quantity you selected exceeds the current inventory (${item.inStock}).';
      }

      if (warning.isNotEmpty) {
        newQuantity = maxAllowed;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: Text('$warning\nAdjusted to allowable level: $maxAllowed'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      if (newQuantity < 1) newQuantity = 1;

      _cartItems[index].quantity = newQuantity;
      notifyListeners();
    }
  }




  void removeItem(ShoeInCart item) {
    _cartItems.removeWhere((shoe) => shoe.id == item.id);
    _selectedItemIds.remove(item.id); // xóa khỏi danh sách chọn nếu đang chọn
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _selectedItemIds.clear();
    notifyListeners();
  }

  // --- MULTI SELECT SUPPORT ---

  void toggleSelectItem(String id) {
    if (_selectedItemIds.contains(id)) {
      _selectedItemIds.remove(id);
    } else {
      _selectedItemIds.add(id);
    }
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItemIds.clear();
    notifyListeners();
  }

  void deleteSelectedItems() {
    _cartItems.removeWhere((item) => _selectedItemIds.contains(item.id));
    _selectedItemIds.clear();
    notifyListeners();
  }

  bool isItemSelected(String id) {
    return _selectedItemIds.contains(id);
  }
}
