import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../widgets/food_tile.dart';
import 'add_food_screen.dart';
import 'food_detail_screen.dart';
import 'food_summary_screen.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final p = context.watch<FoodProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('FoodSpend', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.bar_chart), tooltip: 'Summary',
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FoodSummaryScreen())))]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFoodScreen())),
        icon: const Icon(Icons.add), label: const Text('Add food expense')),
      body: RefreshIndicator(onRefresh: p.load, child: ListView(padding: const EdgeInsets.fromLTRB(16,8,16,100), children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFB45A24), Color(0xFFE58A45)]),
          borderRadius: BorderRadius.circular(22)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('THIS MONTH', style: TextStyle(color: Colors.white70, letterSpacing: 1)),
            const SizedBox(height: 8),
            Text('₹${p.thisMonth.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            Text('All-time food spending: ₹${p.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
          ])),
        const SizedBox(height: 22),
        const Text('Food expense history', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (p.isLoading) const Center(child: Padding(padding: EdgeInsets.all(28), child: CircularProgressIndicator()))
        else if (p.error != null && p.items.isEmpty) _StateMessage(p.error!, p.load)
        else if (p.items.isEmpty) const _StateMessage('No food expenses yet. Add your first meal or grocery purchase.')
        else ...p.items.map((e) => FoodTile(item: e, onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => FoodDetailScreen(item: e))))),
      ])),
    );
  }
}
class _StateMessage extends StatelessWidget {
  final String message; final Future<void> Function()? retry;
  const _StateMessage(this.message, [this.retry]);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(28),
    child: Column(children: [const Icon(Icons.lunch_dining, size: 42, color: Colors.grey),
      const SizedBox(height: 8), Text(message, textAlign: TextAlign.center),
      if (retry != null) TextButton(onPressed: retry, child: const Text('Retry'))]));
}
