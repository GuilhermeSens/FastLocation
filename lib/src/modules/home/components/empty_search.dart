import 'package:flutter/material.dart';
class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.location_searching, size: 58), SizedBox(height: 12), Text('Digite um CEP ou pesquise por endereço.')])));
}
