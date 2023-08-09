import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/pages/bag_page.dart';
import 'package:cookmaster_front/pages/category_page.dart';
import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/recipe_page.dart';
import 'package:cookmaster_front/pages/recipe_page.dart';
import 'package:cookmaster_front/services/auth_service.dart';
import 'package:cookmaster_front/store/recipe_store.dart';
import 'package:cookmaster_front/utils/decodeImageBase64.dart';
import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/http/http_client.dart';
import '../app/data/models/ingredient_model.dart';
import '../app/data/repositories/ingredient_repository.dart';
import '../store/ingredient_store.dart';

class HomePage extends StatefulWidget {
  final User? users;
  const HomePage(this.users, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool validateUser = false;

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  _userValidate() {
    if (widget.users != null) {
      return true;
    }
    return false;
  }

  _optionDinamyc() {
    if (widget.users != null) {
      return ListTile(
        leading: Image.asset('assets/images/iconExit.png'),
        title: const Text('Sair da Conta'),
        titleTextStyle: const TextStyle(
          fontFamily: 'JacquesFrancois',
          color: Colors.black,
        ),
        onTap: () async {
          await AuthService().logout();
        },
      );
    } else {
      return ListTile(
        leading: Image.asset(
          'assets/images/logoGoogleDeepOrange.png',
        ),
        title: const Text('Realizar Login'),
        titleTextStyle: const TextStyle(
          fontFamily: 'JacquesFrancois',
          color: Colors.black,
        ),
        onTap: () async {
          AuthService authService = AuthService();
          await authService.signInWithGoogle();
          Get.to(const AuthCheck());
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      storeRecipe.getRecipe();
    });
  }

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
                    child: _userValidate()
                        ? Image.network(widget.users?.photoURL ?? '')
                        : const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          )),
                accountName: Text(widget.users?.displayName ?? 'Sem Login'),
                accountEmail: Text(widget.users?.email ?? 'Sem Login'),
              ),
              ListTile(
                leading: Image.asset('assets/images/iconSend.png'),
                title: const Text('Enviar Receita'),
                titleTextStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                  color: Colors.black,
                ),
                onTap: () async {
                  _userValidate()
                      ? await Get.to(BagPage(user: widget.users))
                      : Get.snackbar('Cook Master',
                          'Necessário realizar login para enviar uma receita.');
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
                  _userValidate()
                      ? await Get.to(BagPage(user: widget.users))
                      : Get.snackbar('Cook Master',
                          'Necessário realizar login para usar a sacola.');
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
                  Get.to(const PageAstro());
                },
              ),
              _optionDinamyc(),
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
                    '  Buscar por Receitas', Icons.search, '/RecipePage'),
                _buildPopUpMenuItem('  Buscar por Ingredientes',
                    Icons.fastfood_outlined, '/ingredientPage')
              ],
              onSelected: (value) async {
                if (value.toString() == '/RecipePage') {
                  await Get.to(
                    const RecipePage(),
                  );
                } else {
                  await store.getAllIngredients();
                  // ignore: use_build_context_synchronously
                  openFilterDelegate(context, store);
                }
              },
            )
          ],
        ),
        body: AnimatedBuilder(
          animation: Listenable.merge(
            [
              storeRecipe.isLoading,
              storeRecipe.error,
              storeRecipe.state,
            ],
          ),
          builder: (context, child) {
            if (storeRecipe.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (storeRecipe.error.value.isNotEmpty) {
              return Center(
                child: Text(
                  storeRecipe.error.value,
                ),
              );
            }

            if (storeRecipe.state.value.isEmpty) {
              return const Center(
                child: Text('lista vazia'),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: storeRecipe.state.value.length,
                itemBuilder: (_, index) {
                  final item = storeRecipe.state.value[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () async {
                        //implementar chamada e filtro da receita
                        await Get.to(const RecipePage());
                      },
                      leading: Base64ImageConverter(
                        base64Image: item.image.replaceAll(RegExp(r'\s+'), ''),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.descricao,
                        style: const TextStyle(
                          fontFamily: 'JacquesFrancois',
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
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
            const CategoryPage(),
          );
        },
        child: const Text('Categorias'),
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
