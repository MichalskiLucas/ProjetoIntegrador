import 'dart:convert';

import 'package:cookmaster_front/app/data/http/exceptions.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/revenue_model.dart';
import 'package:cookmaster_front/common/constants.dart';

abstract class IRevenueRepository {
  Future<List<RevenueModel>> getAllRevenue();
}

class RevenueRepository implements IRevenueRepository {
  final IHttpClient client;
  RevenueRepository({required this.client});

  @override
  Future<List<RevenueModel>> getAllRevenue() async {
    final response = await client.get(
      url: '${urlApi}receita',
    );

    switch (response.statusCode) {
      case 200:
        final List<RevenueModel> categories = [];

        try {
          final body = jsonDecode(response.body);

          if (body is List) {
            for (var item in body) {
              final RevenueModel category = RevenueModel.fromMap(item);
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
