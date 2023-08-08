import 'package:cookmaster_front/app/data/models/revenue_model.dart';
import 'package:cookmaster_front/app/data/repositories/revenue_repository.dart';
import 'package:flutter/material.dart';

import '../app/data/http/exceptions.dart';

class RevenueStore {
  final IRevenueRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<RevenueModel>> state =
      ValueNotifier<List<RevenueModel>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  RevenueStore({required this.repository});

  Future getRevenue() async {
    isLoading.value = true;

    try {
      final result = await repository.getAllRevenue();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
