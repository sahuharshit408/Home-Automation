import 'package:flutter/material.dart';
import 'package:home_controller/screens/dashboard_screen.dart';
import 'package:home_controller/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Home Automation App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
        color: Colors.black,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: DashboardScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(), // Define the route for SettingsScreen
      },// Set DashboardScreen as the home screen
    );
  }
}
