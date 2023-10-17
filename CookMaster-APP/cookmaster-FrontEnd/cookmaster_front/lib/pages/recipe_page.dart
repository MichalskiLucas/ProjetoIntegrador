import 'package:cookmaster_front/app/data/store/recipe_store.dart';
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
    return const Placeholder();
  }
}
