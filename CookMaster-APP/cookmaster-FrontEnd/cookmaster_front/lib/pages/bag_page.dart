// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/bag_repository.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/bag_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/pages/bagView_page.dart';
import 'package:cookmaster_front/utils/openFilterDelegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagPage extends StatefulWidget {
  final UserStore user;
  const BagPage({super.key, required this.user});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
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

  UserStore get _storeUser => widget.user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSimple(
          title: 'Cook Master',
          ctx: context,
        ),
        body: _CookMasterBag(context, store, _storeUser, storeBag),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterBag(BuildContext context, IngredientStore store,
    UserStore storeUser, BagStore storeBag) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 30),
      const SizedBox(
        child: Text(
          'Você ja possui uma sacola, deseja criar uma nova?',
          style: TextStyle(fontFamily: 'JacquesFrancois', fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: Image.asset('assets/images/logo.png'),
      ),
      const SizedBox(
        child: Text(
          'Cook Master',
          style: TextStyle(
            fontFamily: 'JacquesFrancois',
            fontSize: 25,
          ),
        ),
      ),
      const SizedBox(height: 250),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.deepOrange;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
                onPressed: () async {
                  await storeBag.getBag(storeUser.state.value.id);
                  await Get.to(
                    () => BagViewPage(
                      bagStore: storeBag,
                    ),
                  );
                },
                child: const Text(
                  'Visualizar',
                  style: TextStyle(
                    fontFamily: 'JacquesFrancois',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 95),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.deepOrange;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
                onPressed: () async {
                  await store.getAllIngredients();
                  openFilterDelegate(
                      context, store, "Finalizar", storeUser.state.value.id);
                },
                child: const Text(
                  'Criar',
                  style: TextStyle(
                    fontFamily: 'JacquesFrancois',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
