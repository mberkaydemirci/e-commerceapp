import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String? _name;
  String? _email;
  String? _id;
  String? _stripeId;
  double? _priceSum = 0;

//  getters
  String? get name {
    return _name;
  }

  String? get email {
    return _email;
  }

  String? get id {
    return _id;
  }

  String? get stripeId {
    return _stripeId;
  }

  // public variables
  List<CartItemModel>? cart;
  double? totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _name = snapshot.data()![NAME];
    _email = snapshot.data()![EMAIL];
    _id = snapshot.data()![ID];
    _stripeId = snapshot.data()![STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot.data()![CART]);
    totalCartPrice = snapshot.data()![CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data()![CART]);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
      print("*******************************" + cartItem.toString());
    }
    return convertedCart;
  }

  double? getTotalPrice({List? cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map<String, dynamic> cartItem in cart) {
      if (_priceSum != null && cartItem["price"] != null) {
        _priceSum = cartItem["price"];
      }
    }

    double? total = _priceSum;
    return total;
  }
}
