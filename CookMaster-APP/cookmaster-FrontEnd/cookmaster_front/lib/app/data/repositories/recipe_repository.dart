import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/recipe_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IRecipeRepository {
  Future<List<RecipeModel>> getAllRecipe();
}

class RecipeRepository implements IRecipeRepository {
  final IHttpClient client;
  RecipeRepository({required this.client});

  @override
  Future<List<RecipeModel>> getAllRecipe() async {
    final response = await client.get(
        //url: '${urlApi}receita',
        url: 'https://run.mocky.io/v3/20ee96f6-f127-4eca-8ed1-42181243b7a0');

    switch (response.statusCode) {
      case 200:
        final List<RecipeModel> recipes = [];

        try {
          final body = jsonDecode(response.body);

          if (body is List) {
            for (var item in body) {
              final RecipeModel recipe = RecipeModel.fromMap(item);
              recipes.add(recipe);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return recipes;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de ingredientes');
    }
  }
}
