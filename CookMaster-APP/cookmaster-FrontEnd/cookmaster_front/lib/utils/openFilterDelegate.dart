// ignore_for_file: unused_local_variable, unnecessary_null_comparison, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/pages/recipeCategory.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openFilterDelegate(BuildContext context, IngredientStore store,
    String applyButtonText, int userId, UserStore storeUser) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];
  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

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
    onApplyButtonClick: (List<IngredientModel>? list) async {
      if (list != null && list.isNotEmpty) {
        selectedIngredients = list;
        await storeRecipe.getRecipeIngredient(list);
        Get.to(() => RecipeByCategory(storeRecipe: storeRecipe, storeUser: storeUser));
      } else {
        if (!Get.isSnackbarOpen) {
          Get.snackbar(
            'Cook Master',
            'Não foi selecionado nenhum ingrediente!',
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.warning),
            backgroundColor: Colors.yellow,
          );
        }
      }
    },
  );
}
