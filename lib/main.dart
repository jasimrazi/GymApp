import 'package:flutter/material.dart';
import 'package:gymapp/screens/landing_page.dart';
import 'package:gymapp/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LandingPage(),
    );
  }
}

