import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reservasi/barak/order_details_screen.dart';
import 'package:reservasi/login_screen.dart';
import 'package:reservasi/home_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/select_barak_screen.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    var initialSize = Size(720, 512);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
    appWindow.title = 'Baron (Barak Online)';
  });
}

class MyApp extends StatelessWidget {
  static User user = new User(username: '', kategori: '');
  const MyApp({super.key});

  static String getIDR(int number) {
    NumberFormat formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    String formatted = formatter.format(number);
    return formatted.substring(0, formatted.length - 3);
  }

  static int getInt(String str) {
    return int.tryParse(str.replaceAll(RegExp('[^0-9]'), '')) ?? 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      // home: OrderDetailsScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginScreen(),
      },
    );
  }
}
