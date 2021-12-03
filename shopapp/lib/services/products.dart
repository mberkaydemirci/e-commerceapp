import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/product.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "products";

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection("products").get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String? productName}) {
    String searchKey = productName![0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }
}
