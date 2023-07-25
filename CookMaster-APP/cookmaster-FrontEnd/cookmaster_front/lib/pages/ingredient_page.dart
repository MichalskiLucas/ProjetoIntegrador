import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSearch(
          ctx: context,
          labelText: 'Consultar Ingrediente',
        ),
        body: _CookMasterSearchIngredient(context),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterSearchIngredient(BuildContext context) {
  return const Material(
    child: SizedBox(),
  );
}
