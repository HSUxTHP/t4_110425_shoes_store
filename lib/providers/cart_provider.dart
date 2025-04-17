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
      if (_cartItems[index].quantity < 99) {
        _cartItems[index].quantity++;
      }
    } else {
      if (item.dateSell.isBefore(DateTime.now())) {
        _cartItems.add(item);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Item cannot be added because the dateSell is less than today.'),
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

  void updateQuantity(ShoeInCart item, int newQuantity) {
    int index = _cartItems.indexWhere((shoe) => shoe.id == item.id);
    if (index != -1) {
      _cartItems[index].quantity = newQuantity.clamp(1, 99);
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
