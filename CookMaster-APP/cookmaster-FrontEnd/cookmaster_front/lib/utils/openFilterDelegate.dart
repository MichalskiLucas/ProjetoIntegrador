import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openFilterDelegate(BuildContext context, IngredientStore store,
    String applyButtonText, int userId) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  void postBag(List<IngredientModel> selectedIngredients) async {
    try {
      await storeBag.postBag(userId, selectedIngredients);
      Get.snackbar(
        'Sacola Criada',
        'Obrigado por criar a sacola!',
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.verified),
      );
    } catch (e) {
      Get.snackbar(
        'Erro Sacola',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.verified),
      );
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
        }
      }
    },
  );
}
