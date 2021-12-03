import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/user.dart';
import 'dart:async';
import 'package:shopapp/services/products.dart';

class ProductProvider with ChangeNotifier {
  ProductService _productService = ProductService();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productService.getProducts();
    notifyListeners();
  }

  Future search({String? productName}) async {
    productsSearched =
        await _productService.searchProducts(productName: productName);
    notifyListeners();
  }
}
