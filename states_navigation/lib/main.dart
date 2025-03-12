import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/item_provider.dart';
import './providers/theme_provider.dart'; // Add this
import './screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemProvider>(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-Screen Navigation',
      theme: themeProvider.currentTheme, // Use the current theme
      home: HomeScreen(),
    );
  }
}