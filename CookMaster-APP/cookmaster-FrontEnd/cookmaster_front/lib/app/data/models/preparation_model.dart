class PreparationModel {
  String? descricao;

  PreparationModel({
    this.descricao,
  });

  factory PreparationModel.fromMap(Map<String, dynamic> map) {
    return PreparationModel(
      descricao: map['descricao'],
    );
  }
}
