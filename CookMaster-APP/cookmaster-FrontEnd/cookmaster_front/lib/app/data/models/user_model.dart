class UserModel {
  final String nome;
  final String email;

  UserModel({
    required this.email,
    required this.nome,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      nome: map['nome'],
    );
  }
}
