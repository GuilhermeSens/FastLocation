class EnderecoModel {
  final String cep, logradouro, bairro, cidade, uf, complemento;
  const EnderecoModel({required this.cep, required this.logradouro, required this.bairro, required this.cidade, required this.uf, this.complemento = ''});
  factory EnderecoModel.fromJson(Map<String, dynamic> j) => EnderecoModel(
    cep: (j['cep'] ?? '').toString(), logradouro: (j['logradouro'] ?? '').toString(),
    bairro: (j['bairro'] ?? '').toString(), cidade: (j['localidade'] ?? '').toString(),
    uf: (j['uf'] ?? '').toString(), complemento: (j['complemento'] ?? '').toString(),
  );
  factory EnderecoModel.fromStored(Map<String, dynamic> j) => EnderecoModel.fromJson(j);
  Map<String, dynamic> toJson() => {'cep':cep,'logradouro':logradouro,'bairro':bairro,'localidade':cidade,'uf':uf,'complemento':complemento};
  String get enderecoCompleto => '$logradouro, $bairro, $cidade - $uf, Brasil';
}
