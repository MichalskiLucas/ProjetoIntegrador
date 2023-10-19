import 'package:cookmaster_front/app/data/models/vote_model.dart';
import 'package:cookmaster_front/app/data/repositories/vote_repository.dart';
import 'package:flutter/material.dart';

import '../http/exceptions.dart';

class VoteStore {
  final IVoteRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<int> state = ValueNotifier<int>(0);
  final ValueNotifier<VoteModel> stateGet =
      ValueNotifier<VoteModel>(VoteModel());

  final ValueNotifier<String> error = ValueNotifier<String>('');

  VoteStore({required this.repository});

  Future<void> postVote(int voto, int idUsuario, int idReceita) async {
    isLoading.value = true;

    try {
      final result = await repository.postVote(voto, idUsuario, idReceita);
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }

  Future getVote(int? userId) async {
    isLoading.value = true;
    try {
      final result = await repository.getVoteByUser(userId!);
      stateGet.value = result;
    } on NotFoundException catch (e) {
      null;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
