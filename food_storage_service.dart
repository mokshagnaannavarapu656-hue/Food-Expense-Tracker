import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_expense.dart';
class FoodStorageService {
  static const _key = 'food_expenses_v1';
  Future<List<FoodExpense>> read() async {
    final raw = (await SharedPreferences.getInstance()).getString(_key);
    if (raw == null || raw.isEmpty) return [];
    return (jsonDecode(raw) as List).map((e) => FoodExpense.fromJson(e as Map<String, dynamic>)).toList();
  }
  Future<void> save(List<FoodExpense> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(items.map((e) => e.toJson()).toList()));
  }
}
