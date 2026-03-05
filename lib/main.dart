import 'package:flutter/material.dart';
import 'screens/expenses_home_page.dart';  // Add this import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Fix: change 'primarySavings' to 'primarySwatch'
        useMaterial3: true,
      ),
      home: const ExpensesHomePage(),
      debugShowCheckedModeBanner: false,  // Fix: change 'debugShowCheckedModeButton' to 'debugShowCheckedModeBanner'
    );
  }
}