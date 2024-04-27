import 'package:flutter/material.dart';
import 'package:meet_virtually/screens/home_screen.dart';
import 'package:meet_virtually/screens/login_sccreen.dart';
import 'package:meet_virtually/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meet Virtually',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home' : (context) =>HomeScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
