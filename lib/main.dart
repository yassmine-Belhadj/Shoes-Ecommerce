import 'package:aftercode/screens/AccountSettingsScreen.dart';
import 'package:aftercode/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter SQLite Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[850],
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
      ),
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(),
      routes: {
        '/account-settings': (context) => const AccountSettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}