class VoteModel {
  final int voto;
  final int idUsuario;
  final int idReceita;

  VoteModel({
    required this.idUsuario,
    required this.voto,
    required this.idReceita,
  });

  factory VoteModel.fromMap(Map<String, dynamic> map) {
    return VoteModel(
      idReceita: map['idReceita'],
      idUsuario: map['idUsuario'],
      voto: map['voto'],
    );
  }
}
