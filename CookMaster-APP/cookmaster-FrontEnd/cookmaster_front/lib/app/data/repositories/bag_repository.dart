import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';

abstract class IBagRepository {
  Future<int> postBag(int userId, List<IngredientModel> list);
}

class BagRepository implements IBagRepository {
  final IHttpClient client;

  BagRepository({required this.client});

  @override
  Future<int> postBag(int userId, List<IngredientModel> list) async {
    final List<int?> ingredients = list.map((ingredient) {
      return ingredient.id;
    }).toList();

    final json = jsonEncode(
      {
        'usuarioId': '$userId',
        'ingredients': ingredients,
      },
    );

    print(json);

    final response = await client.post(
        url: /*'${urlApi}sacola'*/
            'https://run.mocky.io/v3/978d3ecf-309a-411c-9153-05755e8de3db',
        headers: {'Content-Type': 'application/json'},
        jsonBody: json);

    switch (response.statusCode) {
      case 200:
        return 200;
      case 404:
        throw NotFoundException('Url informada não está válida');
      default:
        throw Exception('Erro ao realizar cadastro de sacola');
    }
  }

  // @override
  // Future<BagModel> getUser(String email) async {
  //   final response = await client.get(
  //     url: '${urlApi}usuario/filterEmail?email=$email',
  //   );

  //   switch (response.statusCode) {
  //     case 200:
  //       try {
  //         final body = utf8.decode(response.bodyBytes);
  //         final dynamic decodedBody = jsonDecode(body);

  //         return BagModel.fromMap(decodedBody);
  //       } catch (e) {
  //         throw Exception('Erro ao fazer parsing do JSON');
  //       }
  //     case 404:
  //       throw NotFoundException('Url informada não esta válida');
  //     default:
  //       throw Exception('Erro ao realizar consulta de unidades de medida');
  //   }
}
