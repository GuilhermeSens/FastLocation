import 'package:flutter/material.dart';
import '../model/endereco_model.dart';
class EnderecoCard extends StatelessWidget {
  final EnderecoModel endereco;
  final VoidCallback? onRoute;
  const EnderecoCard({super.key, required this.endereco, this.onRoute});
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(endereco.cep, style: Theme.of(context).textTheme.titleMedium),
    Text('Rua: ${endereco.logradouro.isEmpty ? "Não informada" : endereco.logradouro}'),
    Text('Bairro: ${endereco.bairro}'), Text('Cidade: ${endereco.cidade} - ${endereco.uf}'),
    if (endereco.complemento.isNotEmpty) Text('Complemento: ${endereco.complemento}'),
    if (onRoute != null) Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: onRoute, icon: const Icon(Icons.directions), label: const Text('Traçar rota'))),
  ])));
}
