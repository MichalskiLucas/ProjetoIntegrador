// ignore_for_file: non_constant_identifier_names, unused_import, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/CardRecipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage(
      {super.key, required this.storeUser, required this.storeRecipe});
  final UserStore storeUser;
  final RecipeStore storeRecipe;
  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  RecipeStore get _storeRecipe => widget.storeRecipe;

  @override
  void initState() {
    super.initState();
  }

  UserStore get _storeUser => widget.storeUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSearch(
          ctx: context,
          labelText: 'Buscar Receita',
          storeRecipe: _storeRecipe,
        ),
        body: _CookMasterSearchRecipe(context, _storeUser, _storeRecipe),
      ),
    );
  }
}

Widget _CookMasterSearchRecipe(
    BuildContext context, UserStore storeUser, RecipeStore recipeStore) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          CardRecipe(
            userStore: storeUser,
            store: recipeStore,
          ),
        ],
      ),
    ),
  );
}
