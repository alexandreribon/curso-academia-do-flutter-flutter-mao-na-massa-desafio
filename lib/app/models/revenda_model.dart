import 'dart:convert';

class RevendaModel {
  String tipo;
  String nome;
  String cor;
  double nota;
  String tempoMedio;
  String horarioFunc;
  bool melhorPreco;
  double preco;

  RevendaModel({
    this.tipo,
    this.nome,
    this.cor,
    this.nota,
    this.tempoMedio,
    this.horarioFunc,
    this.melhorPreco,
    this.preco,
  });

  Map<String, dynamic> toMap() {
    return {
      'tipo': tipo,
      'nome': nome,
      'cor': cor,
      'nota': nota,
      'tempoMedio': tempoMedio,
      'horarioFunc': horarioFunc,
      'melhorPreco': melhorPreco,
      'preco': preco,
    };
  }

  factory RevendaModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RevendaModel(
      tipo: map['tipo'],
      nome: map['nome'],
      cor: map['cor'],
      nota: map['nota'],
      tempoMedio: map['tempoMedio'],
      horarioFunc: map['horarioFunc'],
      melhorPreco: map['melhorPreco'],
      preco: map['preco'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RevendaModel.fromJson(String source) => RevendaModel.fromMap(json.decode(source));
}
