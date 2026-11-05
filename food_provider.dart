import 'package:flutter/foundation.dart';
import '../models/food_expense.dart';
import '../services/food_storage_service.dart';
class FoodProvider extends ChangeNotifier {
  final _storage = FoodStorageService();
  List<FoodExpense> _items = [];
  bool isLoading = true;
  String? error;
  List<FoodExpense> get items => List.unmodifiable(_items);
  double get total => _items.fold(0, (s, e) => s + e.amount);
  double get thisMonth {
    final n = DateTime.now();
    return _items.where((e) => e.date.year == n.year && e.date.month == n.month)
      .fold(0, (s, e) => s + e.amount);
  }
  Future<void> load() async {
    isLoading = true; error = null; notifyListeners();
    try { _items = await _storage.read(); _items.sort((a,b) => b.date.compareTo(a.date)); }
    catch (_) { error = 'Could not load food expenses. Retry.'; }
    finally { isLoading = false; notifyListeners(); }
  }
  Future<void> add(FoodExpense item) async {
    _items.insert(0, item);
    try { await _storage.save(_items); error = null; }
    catch (_) { _items.removeWhere((e) => e.id == item.id); rethrow; }
    notifyListeners();
  }
  Future<void> remove(String id) async {
    final old = List<FoodExpense>.from(_items);
    _items.removeWhere((e) => e.id == id);
    try { await _storage.save(_items); }
    catch (_) { _items = old; rethrow; }
    notifyListeners();
  }
  Map<String,double> byCategory() {
    final result = <String,double>{};
    for (final e in _items) { result[e.category] = (result[e.category] ?? 0) + e.amount; }
    return result;
  }
}
