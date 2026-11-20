import '../../../shared/storage/local_storage.dart';
import '../model/endereco_model.dart';
class HistoricoRepository {
  List<EnderecoModel> listar() => LocalStorage.all();
  Future<void> salvar(EnderecoModel e) => LocalStorage.save(e);
  Future<void> limpar() => LocalStorage.clear();
}
