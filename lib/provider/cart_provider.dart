import 'package:flutter/material.dart';
import 'package:exam/model/product.dart';
import 'package:exam/services/api_service.dart';

class CartProvider with ChangeNotifier {
  List<Product> _catalog = [];
  final Map<int, int> _items = {};
  bool _isLoading = false;

  List<Product> get catalog => _catalog;
  Map<int, int> get items => _items;
  bool get isLoading => _isLoading;
  int get totalItems => _items.values.fold(0, (sum, qty) => sum + qty);

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _catalog = await ApiService().getProducts();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addItem(int productId) {
    _items[productId] = (_items[productId] ?? 0) + 1;
    notifyListeners();
  }

  void removeItem(int productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]! > 1) {
        _items[productId] = _items[productId]! - 1;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((productId, quantity) {
      try {
        final product = _catalog.firstWhere((p) => p.id == productId);
        total += product.price * quantity;
      } catch (e) {
        debugPrint("Error calculating price for product $productId: $e");
      }
    });
    return total;
  }
}
