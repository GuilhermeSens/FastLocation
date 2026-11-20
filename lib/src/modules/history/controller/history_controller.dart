import 'package:mobx/mobx.dart';
import '../../home/model/endereco_model.dart';
import '../../home/repositories/historico_repository.dart';
class HistoryController {
  final repo = HistoricoRepository();
  final ObservableList<EnderecoModel> items = ObservableList<EnderecoModel>();
  void load() => runInAction(() { items.clear(); items.addAll(repo.listar()); });
  Future<void> clear() async { await repo.limpar(); load(); }
}
