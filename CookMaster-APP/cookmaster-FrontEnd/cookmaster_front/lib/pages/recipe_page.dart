import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  final RecipeStore storeCookingRecipe;
  const RecipePage({
    super.key,
    required this.storeCookingRecipe,
  });

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSimple(title: "CookMaster", ctx: context),
        body: const SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40, left: 8.0, right: 8.0),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
