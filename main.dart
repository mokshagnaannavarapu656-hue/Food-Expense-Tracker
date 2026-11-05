import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/food_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => FoodProvider()..load(),
    child: const FoodSpendApp(),
  ));
}

class FoodSpendApp extends StatelessWidget {
  const FoodSpendApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FoodSpend',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB45A24)),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF8F3),
      cardTheme: CardThemeData(
        elevation: 0, color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    home: const DashboardScreen(),
  );
}
