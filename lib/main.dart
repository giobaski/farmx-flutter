import 'package:farmx/views/home_page.dart';
import 'package:farmx/views/login_page.dart';
import 'package:farmx/views/my_orders_page.dart';
import 'package:farmx/views/register_page.dart';
import 'package:farmx/views/wishlist_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,

      // initialRoute: isLogged() ? '/home' : '/',
      // initialRoute: '/home',
      routes: {
        '/home' : (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/wishlist': (context) => WishlistPage(),
        '/orders': (context) => MyOrdersPage(),
      },

      home: HomePage(),
    );
  }
}