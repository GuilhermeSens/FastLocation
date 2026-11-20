import '../model/endereco_model.dart';
import '../repositories/endereco_repository.dart';
import '../repositories/historico_repository.dart';
class EnderecoService {
  final EnderecoRepository api = EnderecoRepository();
  final HistoricoRepository historico = HistoricoRepository();
  Future<List<EnderecoModel>> cep(String cep) async {
    final result = await api.buscarCep(cep);
    await historico.salvar(result);
    return [result];
  }
  Future<List<EnderecoModel>> endereco(String uf, String cidade, String rua) async {
    final result = await api.buscarEndereco(uf,cidade,rua);
    for (final e in result) { await historico.salvar(e); }
    return result;
  }
}
