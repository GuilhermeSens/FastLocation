import '../../../http/http_client.dart';
import '../model/endereco_model.dart';
class EnderecoRepository {
  Future<EnderecoModel> buscarCep(String cep) async {
    final limpo = cep.replaceAll(RegExp(r'\D'), '');
    if (limpo.length != 8) throw Exception('Informe um CEP com 8 dígitos.');
    final response = await HttpClient.dio.get('$limpo/json/');
    if (response.data is! Map) throw Exception('Resposta inválida do serviço.');
    final data = Map<String,dynamic>.from(response.data as Map);
    if (data['erro'] == true) throw Exception('CEP não encontrado.');
    return EnderecoModel.fromJson(data);
  }
  Future<List<EnderecoModel>> buscarEndereco(String uf, String cidade, String rua) async {
    if (uf.trim().length != 2 || cidade.trim().length < 3 || rua.trim().length < 3) {
      throw Exception('Informe UF (2 letras), cidade e rua (mínimo 3 caracteres).');
    }
    final url = '${Uri.encodeComponent(uf.trim())}/${Uri.encodeComponent(cidade.trim())}/${Uri.encodeComponent(rua.trim())}/json/';
    final response = await HttpClient.dio.get(url);
    if (response.data is! List) throw Exception('Nenhum endereço encontrado.');
    return (response.data as List).whereType<Map>().map((e) => EnderecoModel.fromJson(Map<String,dynamic>.from(e))).toList();
  }
}
