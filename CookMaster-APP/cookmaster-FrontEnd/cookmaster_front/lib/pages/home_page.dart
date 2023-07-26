// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/bag_page.dart';
import 'package:cookmaster_front/pages/category_page.dart';
import 'package:cookmaster_front/pages/login_page.dart';
import 'package:cookmaster_front/pages/revenue_page.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/http/http_client.dart';
import '../app/data/models/ingredient_model.dart';
import '../app/data/repositories/ingredient_repository.dart';
import '../store/ingredient_store.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.deepOrange),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('assets/images/iconChefAstro.png'),
                ),
                accountName: const Text('Lucas Michalski'),
                accountEmail: const Text('Lucas@gmail.com'),
              ),
              ListTile(
                leading: Image.asset('assets/images/iconSend.png'),
                title: const Text('Enviar Receita'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () {
                  // ignore: avoid_print
                  print('Enviar Receita');
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/iconBag.png'),
                title: const Text('Sacola'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  await Get.to(
                    () => BagPage(),
                  );
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/iconChef.png'),
                title: const Text('Chef Astro'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  await Get.to(
                    () => ChefAstroPage(),
                  );
                },
              ),
              ListTile(
                leading: Image.asset('assets/images/iconExit.png'),
                title: const Text('Sair da Conta'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  await Get.to(
                    () => LoginPage(),
                  );
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CookMaster'),
          titleTextStyle: const TextStyle(
            fontFamily: 'JacquesFrancois',
            fontSize: 15,
          ),
          backgroundColor: Colors.deepOrange,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.search),
              itemBuilder: (context) => [
                _buildPopUpMenuItem(
                    '  Buscar por Receitas', Icons.search, '/revenuePage'),
                _buildPopUpMenuItem('  Buscar por Ingredientes',
                    Icons.fastfood_outlined, '/ingredientPage')
              ],
              onSelected: (value) async {
                if (value.toString() == '/revenuePage') {
                  await Get.to(
                    RevenuePage(),
                  );
                } else {
                  await store.getAllIngredients();
                  openFilterDelegate(context, store);
                }
              },
            )
          ],
        ),
        body: _listCookMasterHomePage(),
      ),
    );
  }
}

Widget _listCookMasterHomePage() {
  return ListView(
    scrollDirection: Axis.vertical,
    children: [
      ElevatedButton(
        onPressed: () async {
          await Get.to(
            CategoryPage(),
          );
        },
        child: Text('Categorias'),
      ),
    ],
  );
}

PopupMenuItem _buildPopUpMenuItem(String title, IconData icon, String value) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(title),
      ],
    ),
  );
}

void openFilterDelegate(BuildContext context, IngredientStore store) async {
  List<IngredientModel> ingredientList = store.state.value;
  List<IngredientModel> selectedIngredients = [];

  await FilterListDelegate.show(
    context: context,
    applyButtonText: 'Filtrar',
    list: ingredientList,
    searchFieldHint: 'Consultar Ingrediente',
    searchFieldStyle: const TextStyle(
      fontFamily: 'JacquesFrancois',
    ),
    selectedListData: selectedIngredients,
    tileLabel: (IngredientModel? item) {
      if (item == null) return '';
      return item.descricao;
    },
    onItemSearch: (IngredientModel item, String query) {
      return item.descricao.toLowerCase().contains(query.toLowerCase());
    },
    onApplyButtonClick: (List<IngredientModel>? list) {
      if (list != null) {
        selectedIngredients = list;
        //fazer algo com a lista de ingredientes selecionados após o clique no botão "Aplicar".
      }
    },
  );
}
