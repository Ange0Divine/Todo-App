import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const CheckMeApp()); // ✅ Now uses const
}

class CheckMeApp extends StatelessWidget {
  const CheckMeApp({super.key}); // ✅ Added const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckMe – Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}