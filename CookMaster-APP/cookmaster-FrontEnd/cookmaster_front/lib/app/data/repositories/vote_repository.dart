import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/vote_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IVoteRepository {
  Future<int> postVote(int voto, int idUsuario, int idreceita);
  Future<VoteModel> getVoteByUser(int userId);
}

class VoteRepository implements IVoteRepository {
  final IHttpClient client;

  VoteRepository({required this.client});

  @override
  Future<int> postVote(int voto, int idUsuario, int idReceita) async {
    final response = await client.post(
      url:
          '${urlApi}voto' /*'https://run.mocky.io/v3/49344b80-bb98-47cf-a857-0cbed3a2f1c0'*/,
      headers: {'Content-Type': 'application/json'},
      jsonBody: jsonEncode(
        {
          'voto': voto,
          'idUsuario': idUsuario,
          'idReceita': idReceita,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de usuário');
    }
  }

  @override
  Future<VoteModel> getVoteByUser(int userId) async {
    final response = await client.get(
      url: '${urlApi}findVotoByUsuario/$userId',
    );

    switch (response.statusCode) {
      case 200:
        try {
          final body = utf8.decode(response.bodyBytes);
          final dynamic decodedBody = jsonDecode(body);

          return VoteModel.fromMap(decodedBody);
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de votos');
    }
  }
}
