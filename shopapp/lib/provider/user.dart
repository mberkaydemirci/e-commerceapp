// ignore_for_file: constant_identifier_names

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/models/cart_item.dart';
import 'package:shopapp/models/order.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/user.dart';
import 'package:shopapp/services/order.dart';
import 'dart:async';
import 'package:shopapp/services/users.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth? _auth = FirebaseAuth.instance;
  User? _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel? _userModel;
  String? uid;
  List<CartItemModel> CART = [];

  //getter

  //public variables
  List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth?.authStateChanges().listen((_onStateChanged));
  }
  Future<bool> signIn(String email, String password) async {
    //try {
    _status = Status.Authenticating;
    notifyListeners();
    await _auth!
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      uid = value.user!.uid;
      print("---------------------------------------");
      print(value.user!.uid);
      _userModel = await _userServices.getUserById(value.user!.uid);
      notifyListeners();
      print("sign In +");
    });
    return true;
    /*} catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }*/
  }

  UserModel? get userModel {
    return _userModel;
  }

  Status get status => _status;
  User? get user => _user;
  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print("CREATE USER");
        _userServices.createUser({
          'cart': CART,
          'name': name,
          'email': email,
          'uid': user.user!.uid,
          'stripeId': '',
          'password': password,
        });
        _userModel = await _userServices.getUserById(user.user!.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User? user) async {
    if (_user == null) {
      _status = Status.Unauthenticated;
      print("ananı götten sikeyim");
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user!.uid);
      print("--------------------------------------------------");
      print(_userModel);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {required ProductModel product,
      required String size,
      required String color}) async {
    //try {
    var uuid = Uuid();
    String cartItemId = uuid.v4();
    List<CartItemModel> cart = _userModel!.cart!;
    Map cartItem = {
      "id": cartItemId,
      "name": product.name,
      "image": product.picture,
      "productId": product.id,
      "price": product.price,
      "size": size,
      "color": color
    };
    CartItemModel item = CartItemModel.fromMap(cartItem);
    // if(!itemExists){
    _user = user;
    print("succes");
    print("CART ITEMS ARE: ${cart.toString()}");
    _userServices.addToCart(userId: uid.toString(), cartItem: item);
    // }

    return true;
    //} catch (e) {
    //print("THE ERROR ${e.toString()}");
    return false;
    //}
  }

  Future<bool> removeFromCart({required CartItemModel cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");

    //try {
    _userServices.removeFromCart(userId: uid.toString(), cartItem: cartItem);
    return true;
    // } catch (e) {
    //print("THE ERROR ${e.toString()}");
    return false;
    //}
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user!.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(uid.toString());
    notifyListeners();
  }
}
