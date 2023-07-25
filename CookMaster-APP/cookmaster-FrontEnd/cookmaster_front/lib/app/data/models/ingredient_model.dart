class IngredientModel {
  final String descricao;

  IngredientModel({required this.descricao});

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(descricao: map['descricao']);
  }
} 