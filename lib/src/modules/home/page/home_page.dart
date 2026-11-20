import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/home_controller.dart';
import '../components/endereco_card.dart';
import '../components/empty_search.dart';
import '../components/last_address.dart';
import '../../../shared/components/map_helper.dart';
import '../../../shared/storage/local_storage.dart';
import '../../history/page/history_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cep = TextEditingController(), uf = TextEditingController(), cidade = TextEditingController(), rua = TextEditingController();
  bool porEndereco = false;
  @override
  void dispose() { cep.dispose(); uf.dispose(); cidade.dispose(); rua.dispose(); super.dispose(); }
  Future<void> _route(dynamic e) async {
    try { await MapHelper.route(e); }
    catch (err) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível abrir a rota: $err'))); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FastLocation'), actions: [IconButton(tooltip: 'Histórico', icon: const Icon(Icons.history), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryPage())).then((_) => setState(() {})))]),
    body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: [
      const Icon(Icons.location_on, size: 64, color: Colors.indigo),
      const Text('Encontre endereços rapidamente', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      SegmentedButton<bool>(segments: const [ButtonSegment(value:false,label:Text('Por CEP')),ButtonSegment(value:true,label:Text('Por endereço'))], selected: {porEndereco}, onSelectionChanged: (v) => setState(() => porEndereco = v.first)),
      const SizedBox(height: 14),
      if (!porEndereco) TextField(controller: cep, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 8, decoration: const InputDecoration(labelText:'CEP (8 números)', border:OutlineInputBorder()))
      else ...[
        TextField(controller: uf, textCapitalization: TextCapitalization.characters, maxLength:2, decoration: const InputDecoration(labelText:'UF (ex.: SC)', border:OutlineInputBorder())),
        const SizedBox(height:8),
        TextField(controller: cidade, decoration: const InputDecoration(labelText:'Cidade', border:OutlineInputBorder())),
        const SizedBox(height:8),
        TextField(controller: rua, decoration: const InputDecoration(labelText:'Rua ou parte do nome', border:OutlineInputBorder())),
      ],
      const SizedBox(height:8),
      FilledButton.icon(onPressed: () => porEndereco ? controller.buscarEndereco(uf.text,cidade.text,rua.text) : controller.buscarCep(cep.text), icon: const Icon(Icons.search), label: const Text('Consultar')),
      const SizedBox(height:18),
      Observer(builder: (_) {
        if (controller.loading.value) return const Center(child: CircularProgressIndicator());
        if (controller.error.value.isNotEmpty) return Text(controller.error.value, textAlign:TextAlign.center, style: const TextStyle(color:Colors.red));
        if (controller.results.isEmpty) return const EmptySearch();
        return Column(children: controller.results.map((e) => EnderecoCard(endereco:e, onRoute:() => _route(e))).toList());
      }),
      if (LocalStorage.all().isNotEmpty) LastAddress(endereco: LocalStorage.all().first),
    ])),
  );
}
