// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  State<RecipeSearchPage> createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSearch(
          ctx: context,
          labelText: 'Consultar Receita',
        ),
        body: _CookMasterSearchRecipe(context),
      ),
    );
  }
}

Widget _CookMasterSearchRecipe(BuildContext context) {
  return const Material(
    child: SizedBox(),
  );
}
