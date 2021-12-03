import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:commerceappadmin/providers/app_states.dart';
import 'package:commerceappadmin/providers/product_provider.dart';
import 'package:commerceappadmin/screens/admin.dart';
import 'package:commerceappadmin/screens/dashboard.dart';
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


/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  }
}*/
