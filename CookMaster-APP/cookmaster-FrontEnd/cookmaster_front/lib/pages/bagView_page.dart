// ignore_for_file: use_build_context_synchronously, must_be_immutable, library_private_types_in_public_api, file_names

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/components/BuildIngredientList.dart';
import 'package:cookmaster_front/pages/home_page.dart';
import 'package:cookmaster_front/utils/openFilterDelegateBag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagViewPage extends StatefulWidget {
  BagViewPage(
      {Key? key,
      required this.storeUser,
      required UserStore user,
      required this.listIngredient,
      this.users,
      this.idBag})
      : super(key: key);
  final UserStore storeUser;
  final User? users;
  List<IngredientModel>? listIngredient;
  final int? idBag;

  @override
  State<BagViewPage> createState() => _BagViewPageState();
}

class _BagViewPageState extends State<BagViewPage> {
  UserStore get _storeUser => widget.storeUser;
  List<IngredientModel>? get _listIngredient => widget.listIngredient;
  User? get _users => widget.users;
  List<IngredientModel>? listIngredient;
  int? get _idBag => widget.idBag;

  final BagStore storeBag = BagStore(
    repository: BagRepository(
      client: HttpClient(),
    ),
  );

  List<IngredientModel> selectedIngredients = [];
  @override
  void initState() {
    super.initState();
    _returnIngredients();
    preencheLista();
  }

  void preencheLista() async {
    setState(() {
      listIngredient = _listIngredient;
    });
  }

  void _returnIngredients() async {
    await store.getAllIngredients();
  }

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
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
      body: buildIngredientList(listIngredient),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final filter = await openFilterDelegateBag(
              context, store, "Finalizar", _storeUser.state.value.id, _idBag);
          if (filter) {
            if (!Get.isSnackbarOpen) {
              Get.snackbar('Sacola Criada/Atualizada',
                  'Sua sacola foi criada. Verifique!',
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.verified),
                  backgroundColor: Colors.green);
            }
          } else {
            if (!Get.isSnackbarOpen) {
              Get.snackbar('Erro Sacola',
                  'Sua sacola não foi criada. Tente novamente mais tarde!',
                  snackPosition: SnackPosition.BOTTOM,
                  icon: const Icon(Icons.error),
                  backgroundColor: Colors.red);
            }
          }
          Get.to(() => HomePage(_users));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
