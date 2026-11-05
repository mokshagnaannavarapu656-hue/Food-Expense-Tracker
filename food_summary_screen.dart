import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
class FoodSummaryScreen extends StatelessWidget {
  const FoodSummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final p=context.watch<FoodProvider>(); final rows=p.byCategory().entries.toList()..sort((a,b)=>b.value.compareTo(a.value));
    return Scaffold(appBar:AppBar(title:const Text('Food spending summary')),
      body:ListView(padding:const EdgeInsets.all(18),children:[
        Card(child:Padding(padding:const EdgeInsets.all(20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          const Text('Total food spending'), const SizedBox(height:6),
          Text('₹${p.total.toStringAsFixed(2)}',style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold,color:Color(0xFFB45A24))),
          Text('This month: ₹${p.thisMonth.toStringAsFixed(2)}'),
        ]))),
        const SizedBox(height:20), const Text('Category breakdown',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),
        const SizedBox(height:10),
        if(rows.isEmpty) const Padding(padding:EdgeInsets.all(24),child:Text('Add food expenses to see the breakdown.',textAlign:TextAlign.center))
        else ...rows.map((r){final f=p.total==0?0.0:r.value/p.total;return Card(child:Padding(padding:const EdgeInsets.all(14),child:Column(children:[
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text(r.key,style:const TextStyle(fontWeight:FontWeight.w600)),Text('₹${r.value.toStringAsFixed(2)}')]),
          const SizedBox(height:8),LinearProgressIndicator(value:f,minHeight:7,borderRadius:BorderRadius.circular(8)),
        ]))));}),
      ]));
  }
}
