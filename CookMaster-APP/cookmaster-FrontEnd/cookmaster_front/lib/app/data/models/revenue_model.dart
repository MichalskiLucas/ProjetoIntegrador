class RevenueModel {
  final int id;
  final String descricao;
  final bool ativo;
  final String image;

  RevenueModel({
    required this.descricao,
    required this.image,
    required this.id,
    required this.ativo,
  });

  factory RevenueModel.fromMap(Map<String, dynamic> map) {
    return RevenueModel(
      descricao: map['descricao'],
      image: map['imagem'],
      id: map['id'],
      ativo: map['ativo'],
    );
  }
}
