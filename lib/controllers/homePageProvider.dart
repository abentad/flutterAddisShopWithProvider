import 'package:ShoppingAppWithProvider/models/product.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  bool _isProcessing = true;
  List<Product> _products = [];

  bool get isProcessing => _isProcessing;
  List<Product> get products => _products;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  setProducts(List<Product> product) {
    _products = product;
    notifyListeners();
  }
}
