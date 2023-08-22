import 'package:cookmaster_front/app/data/models/category_model.dart';
import 'package:cookmaster_front/app/data/models/user_model.dart';
import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/app/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/data/http/exceptions.dart';

class UserStore {
  final IUserRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<UserModel> state =
      ValueNotifier<UserModel>(UserModel(email: '', nome: ''));

  final ValueNotifier<String> error = ValueNotifier<String>('');

  UserStore({required this.repository});

  Future<void> postUser(User? user) async {
    isLoading.value = true;

    try {
      final result = await repository.postUser(user);
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
