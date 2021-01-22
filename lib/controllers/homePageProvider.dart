import 'package:ShoppingAppWithProvider/models/product.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  bool _isProcessing = true;
  List<Product> _products = [];

  int _selectedIndex;

  bool get isProcessing => _isProcessing;
  List<Product> get products => _products;
  int get selectedIndex => _selectedIndex;
  Product getProductByIndex(int index) => _products[index];

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  setProducts(List<Product> product) {
    _products = product;
    notifyListeners();
  }

  setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
