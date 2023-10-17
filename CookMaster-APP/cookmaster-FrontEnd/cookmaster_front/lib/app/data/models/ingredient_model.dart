class IngredientModel {
  int? id;
  String? descricao;
  int? quantidade;
  String? unMedida;

  IngredientModel({
    this.id,
    this.descricao,
    this.quantidade,
    this.unMedida,
  });

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      id: map['id'],
      descricao: map['descricao'],
      quantidade: map['quantidade'],
      unMedida: map['unMedida'],
    );
  }
}
