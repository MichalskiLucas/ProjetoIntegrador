import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class BagStore {
  final IBagRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<int> state = ValueNotifier<int>(0);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  BagStore({required this.repository});

  Future<void> postBag(int userId, List<IngredientModel> list) async {
    isLoading.value = true;

    try {
      final result = await repository.postBag(userId, list);
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
