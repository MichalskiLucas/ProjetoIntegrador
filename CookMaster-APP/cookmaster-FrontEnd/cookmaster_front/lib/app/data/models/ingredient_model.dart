class IngredientModel {
  int? id;
  String? descricao;
  double? qtdIngrediente;
  String? unMedida;
  String? unMedidaStr;
  int? idIngredient;

  IngredientModel(
      {this.id,
      this.descricao,
      this.qtdIngrediente,
      this.unMedida,
      this.unMedidaStr,
      this.idIngredient});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      descricao: map['descricao'],
      qtdIngrediente: map['qtdIngrediente'],
      unMedida: map['unMedida'],
      unMedidaStr: map['unMedidaStr'],
      idIngredient: map['idIngredient'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "qtdIngrediente": qtdIngrediente,
      "unMedida": unMedidaStr,
      "idIngrediente": id,
    };
  }
}
