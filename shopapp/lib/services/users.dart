import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/models/cart_item.dart';
import 'package:shopapp/models/user.dart';

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "users";
  String collection = "users";

  void createUser(Map<String, dynamic> data) {
    try {
      _firestore.collection(collection).doc(data["uid"]).set(data);
      print("USER WAS CREATED");
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        print("==========id is $id=============");

        /*debugPrint("==========NAME is ${doc.data()!['name']}=============");
        debugPrint("==========NAME is ${doc.data()!['name']}=============");
        debugPrint("==========NAME is ${doc.data()!['name']}=============");
        debugPrint("==========NAME is ${doc.data()!['name']}=============");

        print("==========NAME is ${doc.data()!['name']}=============");
        print("==========NAME is ${doc.data()!['name']}=============");
        print("==========NAME is ${doc.data()!['name']}=============");
*/
        return UserModel.fromSnapshot(doc);
      });

  void addToCart({required String userId, required CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart(
      {required String userId, required CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
