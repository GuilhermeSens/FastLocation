import 'package:hive/hive.dart';
import '../../modules/home/model/endereco_model.dart';

class LocalStorage {
  static const boxName = 'historico_ceps';
  static Future<void> init() async => Hive.openBox(boxName);
  static Box get box => Hive.box(boxName);
  static List<EnderecoModel> all() {
    final items = <EnderecoModel>[];
    for (final item in box.values) {
      if (item is Map) {
        try { items.add(EnderecoModel.fromStored(Map<String, dynamic>.from(item))); } catch (_) {}
      }
    }
    return items.reversed.toList();
  }
  static Future<void> save(EnderecoModel item) async {
    // Deduplicar CEP e endereço antes de adicionar ao histórico.
    for (final key in box.keys.toList()) {
      final v = box.get(key);
      if (v is Map && v['cep'] == item.cep && v['logradouro'] == item.logradouro) {
        await box.delete(key);
      }
    }
    await box.add(item.toJson());
  }
  static Future<void> clear() async => box.clear();
}
