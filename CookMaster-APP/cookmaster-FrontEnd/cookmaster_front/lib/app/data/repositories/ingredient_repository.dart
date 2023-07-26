import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:filter_list/filter_list.dart';

abstract class IIngredientRepository {
  Future<List<IngredientModel>> getAllIngredients();
}

class IngredientRepository implements IIngredientRepository {
  final IHttpClient client;

  IngredientRepository({required this.client});

  @override
  Future<List<IngredientModel>> getAllIngredients() async {
    final response = await client.getAllIngredients(
      //url: 'http://localhost:8080/ingrediente',
      url: 'http://172.20.10.3:8080/ingrediente',
    );

    switch (response.statusCode) {
      case 200:
        final List<IngredientModel> ingredients = [];

        try {
          final body = jsonDecode(response.body);

          if (body is List) {
            for (var item in body) {
              final IngredientModel ingredient = IngredientModel.fromMap(item);
              ingredients.add(ingredient);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return ingredients;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de ingredientes');
    }
  }
}
