import 'package:cookmaster_front/app/data/models/recipe_model.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';

import '../app/data/http/exceptions.dart';

class RecipeStore {
  final IRecipeRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<RecipeModel>> state =
      ValueNotifier<List<RecipeModel>>([]);

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
}