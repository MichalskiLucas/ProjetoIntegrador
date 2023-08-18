// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
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
