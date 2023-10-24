// ignore_for_file: use_build_context_synchronously

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/pages/home_page.dart';
import 'package:cookmaster_front/utils/openFilterDelegate.dart';
import 'package:cookmaster_front/utils/openFilterDelegateBag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagViewPage extends StatefulWidget {
  const BagViewPage(
      {Key? key,
      required this.storeUser,
      required UserStore user,
      required this.storeBag})
      : super(key: key);
  final UserStore storeUser;
  final BagStore storeBag;

  @override
  State<BagViewPage> createState() => _BagViewPageState();
}

class _BagViewPageState extends State<BagViewPage> {
  UserStore get _storeUser => widget.storeUser;
  BagStore get _storeBag => widget.storeBag;

  List<IngredientModel> selectedIngredients = [];
  @override
  void initState() {
    super.initState();
    _returnIngredients();
  }

  void _returnBag() async {
    await storeBag.getBag(_storeUser.state.value.id);
  }

  void _returnIngredients() async {
    await store.getAllIngredients();
  }

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        ctx: context,
        title: 'Sacola Cook Master',
      ),
      body: _buildIngredientList(_storeBag, storeBag),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openFilterDelegate(
              context, store, "Finalizar", _storeUser.state.value.id);
        },
      ),
    );
  }
}

Widget _buildIngredientList(BagStore storeBag, BagStore storeBagInt) {
  final ingredients = storeBag.stateBag.value.ingredients ??
      storeBagInt.stateBag.value.ingredients;

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
