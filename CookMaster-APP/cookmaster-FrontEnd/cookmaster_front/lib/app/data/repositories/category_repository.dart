import 'dart:convert';

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/category_model.dart';

import '../http/exceptions.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getAllCategory();
}

class CategoryRepository implements ICategoryRepository {
  final IHttpClient client;

  CategoryRepository({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    final response = await client.get(
      url: 'https://a780-177-220-148-90.ngrok-free.app/categoria',
    );

    switch (response.statusCode) {
      case 200:
        final List<CategoryModel> categories = [];

        try {
          final body = jsonDecode(response.body);

          if (body is List) {
            for (var item in body) {
              final CategoryModel category = CategoryModel.fromMap(item);
              categories.add(category);
            }
          }
        } catch (e) {
          throw Exception('Erro ao fazer parsing do JSON');
        }
        return categories;
      case 404:
        throw NotFoundException('Url informada não esta válida');
      default:
        throw Exception('Erro ao realizar consulta de ingredientes');
    }
  }
}
