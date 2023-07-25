// ignore_for_file: file_names

import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/Button.dart';
import 'package:flutter/material.dart';

class CreateBagPage extends StatefulWidget {
  const CreateBagPage({super.key});

  @override
  State<CreateBagPage> createState() => _CreateBagPageState();
}

class _CreateBagPageState extends State<CreateBagPage> {
  @override
  Widget build(BuildContext context) {
    return _CookMasterSearchIngredient(context);
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterSearchIngredient(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBarSearch(
        ctx: context,
        labelText: 'Consultar Ingrediente',
      ),
      body: const Center(
        child: ButtonFinishBag(),
      ),
    ),
  );
}