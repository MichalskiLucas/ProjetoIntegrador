import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';

class BagViewPage extends StatefulWidget {
  const BagViewPage({Key? key, required this.bagStore}) : super(key: key);
  final BagStore bagStore;

  @override
  State<BagViewPage> createState() => _BagViewPageState();
}

class _BagViewPageState extends State<BagViewPage> {
  BagStore get _storeBag => widget.bagStore;

  @override
  Widget build(BuildContext context) {
    return _CookMasterBagView(context, _storeBag);
  }
}

Widget _CookMasterBagView(BuildContext context, BagStore storeBag) {
  return Scaffold(
    appBar: AppBarSimple(
      ctx: context,
      title: 'Sacola Cook Master',
    ),
    body: _buildIngredientList(storeBag),
  );
}

Widget _buildIngredientList(BagStore storeBag) {
  final ingredients = storeBag.stateBag.value.ingredients;

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
    return Center(
      child: const Text("Você não possui sacola disponível!"),
    );
  }
}

class IngredientCheckbox extends StatefulWidget {
  final IngredientModel ingredient;

  IngredientCheckbox({required this.ingredient});

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
