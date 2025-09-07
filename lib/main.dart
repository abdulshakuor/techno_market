
import 'package:activity1/Cart%20Page.dart';
import 'package:activity1/Checkout%20Page.dart';
import 'package:activity1/Home%20Page.dart';
import 'package:activity1/Login%20Page.dart';
import 'package:activity1/Order%20Tracking%20Page.dart';
import 'package:activity1/ProductPage.dart';
import 'package:activity1/Profile%20Page.dart';
import 'package:activity1/SignUp%20Page.dart';
import 'package:activity1/Settings%20Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // تهيئة Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/checkout': (context) => CheckoutPage(),
        '/order-tracking': (context) => OrderTrackingPage(),
        '/product': (context) => ProductPage(),
      },
    );
  }
}

