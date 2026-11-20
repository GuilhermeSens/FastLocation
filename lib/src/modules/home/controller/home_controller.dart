import 'package:mobx/mobx.dart';
import '../model/endereco_model.dart';
import '../service/endereco_service.dart';
class HomeController {
  final EnderecoService service = EnderecoService();
  final Observable<bool> loading = Observable(false);
  final Observable<String> error = Observable('');
  final ObservableList<EnderecoModel> results = ObservableList<EnderecoModel>();
  Future<void> _search(Future<List<EnderecoModel>> Function() task) async {
    runInAction(() { loading.value = true; error.value = ''; results.clear(); });
    try {
      final found = await task();
      runInAction(() { results.addAll(found); if (found.isEmpty) error.value = 'Nenhum resultado encontrado.'; });
    } catch (e) {
      runInAction(() => error.value = e.toString().replaceFirst('Exception: ', ''));
    } finally { runInAction(() => loading.value = false); }
  }
  Future<void> buscarCep(String cep) => _search(() => service.cep(cep));
  Future<void> buscarEndereco(String uf, String cidade, String rua) => _search(() => service.endereco(uf,cidade,rua));
}
