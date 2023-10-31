import 'package:cookmaster_front/app/data/models/cookingRecipe_model.dart';
import 'package:cookmaster_front/app/data/models/recipeSend_model.dart';
import 'package:cookmaster_front/app/data/models/recipe_model.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class RecipeStore {
  final IRecipeRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<RecipeModel>> state =
      ValueNotifier<List<RecipeModel>>([]);
  final ValueNotifier<int> statePost = ValueNotifier<int>(0);

  final ValueNotifier<CookingRecipeModel> stateCooking =
      ValueNotifier<CookingRecipeModel>(CookingRecipeModel());

  final ValueNotifier<String> error = ValueNotifier<String>('');

  RecipeStore({required this.repository});

  Future getRecipe() async {
    isLoading.value = true;

    try {
      final result = await repository.getAllRecipe();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }

  Future getCookingRecipe(int id) async {
    isLoading.value = true;

    try {
      final result = await repository.getCookingRecipe(id);
      stateCooking.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> postRecipe(RecipeSendModel ingredientsJson) async {
    isLoading.value = true;

    try {
      final result = await repository.postRecipe(ingredientsJson);
      statePost.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
