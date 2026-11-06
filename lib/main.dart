import 'package:flutter/material.dart';
import 'package:catalogo_senati/screens/login_screen.dart';
import 'package:catalogo_senati/screens/home_screen.dart';
import 'package:catalogo_senati/screens/details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo SENATI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF005691), // Azul institucional SENATI
          secondary: const Color(0xFF00A859), // Verde secundario
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}