import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppapp_admin/providers/app_states.dart';
import 'package:shoppapp_admin/providers/product_provider.dart';
import 'package:shoppapp_admin/screens/admin.dart';
import 'package:shoppapp_admin/screens/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppState()),
      ChangeNotifierProvider.value(value: ProductProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin(),
    ),
  ));
}
