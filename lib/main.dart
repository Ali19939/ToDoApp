import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'Screens/home.dart';
import 'models/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.teal,
  ));
  runApp(ChangeNotifierProvider(
      create: (_) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _lightTheme = ThemeData(
      backgroundColor: Colors.teal,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.black),
      ),
      cardColor: Colors.white,
    );
    // #23272a background
    //#2c2f33  container
    ThemeData _darkTheme = ThemeData(
      backgroundColor: const Color(0xFF23272a),
      primaryColor: Colors.amber,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.grey,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
      ),
      cardColor: const Color.fromARGB(255, 54, 57, 62),
    );

    final myProvider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myProvider.dark ? _darkTheme : _lightTheme,
      home: const HomeScreen(),
    );
  }
}
