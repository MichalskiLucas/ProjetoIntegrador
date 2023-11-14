// ignore_for_file: file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/components/IngredientCheckbox.dart';
import 'package:flutter/material.dart';

Widget buildIngredientList(List<IngredientModel>? ingredients) {
  if (ingredients != null) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return IngredientCheckbox(
          ingredient: ingredient,
        );
      },
    );
  } else {
    return const Center(
      child: Text("Você não possui ingredientes na sacola. Adicione!!"),
    );
  }
}
