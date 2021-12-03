import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
//  constants

  static const CATEGORY = 'category';
  static const PICTURE = 'picture';
  static const FEATURED = 'featured';
  static const ID = 'id';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const QUANTITY = 'quantity';
  static const SALE = 'sale';
  static const SIZE = 'sizes';
  //static const DESCRIPTION = 'description';
  static const BRAND = 'brand';
  static const COLORS = 'colors';

//  private variables
  late String _brand;
  late String _category;
  late String _id;
  late String _name;
  late String _picture;
  late double _price;
  late int _quantity;
  late List<dynamic> _colors;
  late List<dynamic> _size;
  late bool _featured;
  late bool _sale;
  //late String _description;

//  getters
  String get brand => _brand;
  String get category => _category;
  String get id => _id;
  String get name => _name;
  String get picture => _picture;
  double get price => _price;
  int get quantity => _quantity;
  List<dynamic> get colors => _colors;
  List<dynamic> get size => _size;
  bool get featured => _featured;
  bool get sale => _sale;

  //String get description => _description;

  ProductModel.fromSnapshot(DocumentSnapshot<Map<dynamic, dynamic>> snapshot) {
    _featured = snapshot.data()![FEATURED];
    _brand = snapshot.data()![BRAND];
    _category = snapshot.data()![CATEGORY];
    _id = snapshot.data()![ID];
    _name = snapshot.data()![NAME];
    _picture = snapshot.data()![PICTURE];
    _quantity = int.parse(snapshot.data()![QUANTITY]);
    _price = double.parse(snapshot.data()![PRICE]);
    _colors = snapshot.data()![COLORS];
    _size = snapshot.data()![SIZE];
    _sale = snapshot.data()![SALE];

    //_description = snapshot.data()![DESCRIPTION];
  }
}
