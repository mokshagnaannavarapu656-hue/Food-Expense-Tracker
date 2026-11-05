import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_expense.dart';
import '../providers/food_provider.dart';
class FoodDetailScreen extends StatelessWidget {
  final FoodExpense item;
  const FoodDetailScreen({super.key, required this.item});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Food expense details')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const CircleAvatar(radius:34, backgroundColor:Color(0xFFFFEBDD), child:Icon(Icons.restaurant, size:34, color:Color(0xFFB45A24))),
      const SizedBox(height:16),
      Text(item.item, textAlign:TextAlign.center, style:const TextStyle(fontSize:23,fontWeight:FontWeight.bold)),
      Text('₹${item.amount.toStringAsFixed(2)}', textAlign:TextAlign.center, style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold,color:Color(0xFFB45A24))),
      const SizedBox(height:24),
      _Info('Category',item.category), _Info('Date','${item.date.day}/${item.date.month}/${item.date.year}'),
      _Info('Restaurant / shop',item.place.isEmpty?'Not specified':item.place), _Info('Note',item.note.isEmpty?'No note added':item.note),
      const SizedBox(height:24),
      OutlinedButton.icon(style:OutlinedButton.styleFrom(foregroundColor:Colors.red), icon:const Icon(Icons.delete_outline),
        label:const Text('Delete expense'), onPressed:() async {
          final ok = await showDialog<bool>(context:context,builder:(ctx)=>AlertDialog(title:const Text('Delete expense?'),
            content:const Text('This record will be removed from this device.'), actions:[
              TextButton(onPressed:()=>Navigator.pop(ctx,false),child:const Text('Cancel')),
              FilledButton(onPressed:()=>Navigator.pop(ctx,true),child:const Text('Delete'))]));
          if(ok==true && context.mounted) { try { await context.read<FoodProvider>().remove(item.id); if(context.mounted) Navigator.pop(context); }
            catch (_) { if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Delete failed.'))); } }
        }),
    ]));
}
class _Info extends StatelessWidget {
  final String label,value; const _Info(this.label,this.value);
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:11),
    child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[SizedBox(width:125,child:Text(label,style:TextStyle(color:Colors.grey.shade600))),Expanded(child:Text(value,style:const TextStyle(fontWeight:FontWeight.w500)))]));
}
