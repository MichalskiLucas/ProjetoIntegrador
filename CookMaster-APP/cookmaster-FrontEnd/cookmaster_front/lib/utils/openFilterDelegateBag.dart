// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String> openFilterDelegateBag(BuildContext context,
    IngredientStore store, String applyButtonText, int userId) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  String _messageIngredient = "";

  void postBag(List<IngredientModel>? selectedIngredients) async {
    try {
      await storeBag.postBag(userId, selectedIngredients);
    } catch (e) {
      _messageIngredient = 'Ocorreu um erro ao salvar sacola!';
    }
  }

  await FilterListDelegate.show(
    context: context,
    applyButtonText: applyButtonText,
    list: ingredientList,
    searchFieldHint: 'Consultar Ingrediente',
    searchFieldStyle: const TextStyle(
      fontFamily: 'JacquesFrancois',
    ),
    selectedListData: selectedIngredients,
    tileLabel: (IngredientModel? item) {
      if (item == null) return '';
      return item.descricao;
    },
    onItemSearch: (IngredientModel item, String query) {
      return item.descricao!.toLowerCase().contains(query.toLowerCase());
    },
    onApplyButtonClick: (List<IngredientModel>? list) {
      if (list != null) {
        selectedIngredients = list;

        if (applyButtonText == "Finalizar") {
          postBag(selectedIngredients);
          _messageIngredient = 'Obrigado por criar a sacola!';
        }
      }
    },
  );

  return _messageIngredient;
}
