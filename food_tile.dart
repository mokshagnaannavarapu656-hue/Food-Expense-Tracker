import 'package:flutter/material.dart';
import '../models/food_expense.dart';
class FoodTile extends StatelessWidget {
  final FoodExpense item; final VoidCallback onTap;
  const FoodTile({super.key, required this.item, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    onTap: onTap,
    leading: const CircleAvatar(backgroundColor: Color(0xFFFFEBDD),
      child: Icon(Icons.restaurant, color: Color(0xFFB45A24))),
    title: Text(item.item, maxLines: 1, overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: Text('${item.category} • ${item.date.day}/${item.date.month}/${item.date.year}'),
    trailing: Text('₹${item.amount.toStringAsFixed(2)}',
      style: const TextStyle(fontWeight: FontWeight.bold)),
  ));
}
