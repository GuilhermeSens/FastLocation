
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller/history_controller.dart';
import '../../home/components/endereco_card.dart';
import '../../../shared/components/map_helper.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = HistoryController();

  @override
  void initState() {
    super.initState();
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            tooltip: 'Limpar histórico',
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await controller.clear();
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.items.isEmpty) {
            return const Center(
              child: Text('Nenhum endereço no histórico.'),
            );
          }

          return ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final endereco = controller.items[index];

              return EnderecoCard(
                endereco: endereco,
                onRoute: () => MapHelper.route(
                  '${endereco.logradouro}, '
                  '${endereco.bairro}, '
                  '${endereco.cidade} - ${endereco.uf}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
