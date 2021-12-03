import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 10,
            right: 20,
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.menu),
            )),
        Positioned(
            top: 10,
            right: 60,
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.shopping_cart),
            )),
        Positioned(
            top: 10,
            right: 100,
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.person),
            )),
      ],
    );
  }
}
