// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class IngredientCheckbox extends StatefulWidget {
  final IngredientModel ingredient;

  const IngredientCheckbox({super.key, required this.ingredient});

  @override
  _IngredientCheckboxState createState() => _IngredientCheckboxState();
}

class _IngredientCheckboxState extends State<IngredientCheckbox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.ingredient.descricao ?? ''),
      value: isSelected,
      onChanged: (value) {
        setState(() {
          isSelected = value!;
        });
      },
    );
  }
}
