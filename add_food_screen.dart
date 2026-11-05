import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_expense.dart';
import '../providers/food_provider.dart';
class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});
  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}
class _AddFoodScreenState extends State<AddFoodScreen> {
  final _key = GlobalKey<FormState>();
  final _item = TextEditingController(), _amount = TextEditingController(),
    _place = TextEditingController(), _note = TextEditingController();
  final _categories = const ['Breakfast','Lunch','Dinner','Snacks','Groceries','Beverages','Eating Out','Other'];
  String _category = 'Lunch'; DateTime _date = DateTime.now(); bool _saving = false;
  @override
  void dispose() { _item.dispose(); _amount.dispose(); _place.dispose(); _note.dispose(); super.dispose(); }
  Future<void> _save() async {
    if (!_key.currentState!.validate() || _saving) return;
    setState(() => _saving = true);
    try {
      await context.read<FoodProvider>().add(FoodExpense(
        id: DateTime.now().microsecondsSinceEpoch.toString(), item: _item.text.trim(),
        category: _category, amount: double.parse(_amount.text.trim()), date: _date,
        place: _place.text.trim(), note: _note.text.trim()));
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Save failed. Please retry.')));
    } finally { if (mounted) setState(() => _saving = false); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Add food expense')),
    body: Form(key: _key, child: ListView(padding: const EdgeInsets.all(18), children: [
      TextFormField(controller: _item, decoration: const InputDecoration(labelText: 'Food / item name', hintText: 'e.g. Lunch thali'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter food or item name' : null),
      const SizedBox(height: 14),
      TextFormField(controller: _amount, keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ '),
        validator: (v) { final n = double.tryParse(v?.trim() ?? ''); return n == null || n <= 0 ? 'Enter amount greater than zero' : null; }),
      const SizedBox(height: 14),
      DropdownButtonFormField<String>(value: _category, decoration: const InputDecoration(labelText: 'Category'),
        items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
        onChanged: (v) => setState(() => _category = v ?? _category)),
      const SizedBox(height: 14),
      TextFormField(controller: _place, decoration: const InputDecoration(labelText: 'Restaurant / shop (optional)')),
      const SizedBox(height: 14),
      OutlinedButton.icon(icon: const Icon(Icons.calendar_month),
        label: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
        onPressed: () async { final d = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2100)); if (d != null) setState(() => _date = d); }),
      const SizedBox(height: 14),
      TextFormField(controller: _note, maxLines: 3, decoration: const InputDecoration(labelText: 'Note (optional)')),
      const SizedBox(height: 24),
      FilledButton.icon(onPressed: _saving ? null : _save,
        icon: _saving ? const SizedBox(width:18,height:18,child:CircularProgressIndicator(strokeWidth:2)) : const Icon(Icons.save),
        label: Text(_saving ? 'Saving...' : 'Save expense')),
    ])));
}
