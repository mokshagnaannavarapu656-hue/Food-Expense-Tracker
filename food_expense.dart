class FoodExpense {
  final String id, item, category, place, note;
  final double amount;
  final DateTime date;
  const FoodExpense({required this.id, required this.item, required this.category,
    required this.amount, required this.date, required this.place, required this.note});
  Map<String, dynamic> toJson() => {
    'id': id, 'item': item, 'category': category, 'amount': amount,
    'date': date.toIso8601String(), 'place': place, 'note': note,
  };
  factory FoodExpense.fromJson(Map<String, dynamic> j) => FoodExpense(
    id: j['id'] as String, item: j['item'] as String, category: j['category'] as String,
    amount: (j['amount'] as num).toDouble(), date: DateTime.parse(j['date'] as String),
    place: (j['place'] ?? '') as String, note: (j['note'] ?? '') as String,
  );
}
