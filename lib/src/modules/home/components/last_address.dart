import 'package:flutter/material.dart';
import '../model/endereco_model.dart';
class LastAddress extends StatelessWidget {
  final EnderecoModel endereco;
  const LastAddress({super.key, required this.endereco});
  @override
  Widget build(BuildContext context) => ListTile(leading: const Icon(Icons.history), title: const Text('Último endereço consultado'), subtitle: Text(endereco.enderecoCompleto));
}
