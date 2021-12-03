import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/widgets/loading.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Loading()],
          ),
        ],
      ),
    );
  }
}
