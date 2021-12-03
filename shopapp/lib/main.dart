import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/provider/app.dart';
import 'package:shopapp/screens/home.dart';
import 'package:shopapp/screens/splash.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/provider/user.dart' as us;
import './screens/login.dart';
import 'package:provider/provider.dart';
import 'provider/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case us.Status.Uninitialized:
        return Splash();
      case us.Status.Unauthenticated:
      case us.Status.Authenticating:
        return Login();
      case us.Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}
