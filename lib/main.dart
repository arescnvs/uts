import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(BraindeadApp());
}

class BraindeadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Braindead',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
