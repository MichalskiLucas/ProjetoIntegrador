class IngredientModel {
  int? id;
  String? descricao;
  double? qtdIngrediente;
  String? unMedida;
  String? unMedidaStr;
  int? idIngrediente;

  IngredientModel(
      {this.id,
      this.descricao,
      this.qtdIngrediente,
      this.unMedida,
      this.unMedidaStr,
      this.idIngrediente});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      descricao: map['descricao'],
      qtdIngrediente: map['qtdIngrediente'],
      unMedida: map['unMedida'],
      unMedidaStr: map['unMedidaStr'],
      idIngrediente: map['idIngrediente'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "qtdIngrediente": qtdIngrediente,
      "unMedida": unMedidaStr,
      "id": id,
    };
  }
}
