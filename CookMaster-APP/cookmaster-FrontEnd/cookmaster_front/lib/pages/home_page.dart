import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/atoms/chat_atom.dart';
import 'package:cookmaster_front/components/CardRecipe.dart';
import 'package:cookmaster_front/components/ListTileCategory.dart';
import 'package:cookmaster_front/pages/bag_page.dart';
import 'package:cookmaster_front/pages/category_page.dart';
import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/recipe_page.dart';
import 'package:cookmaster_front/app/data/services/auth_service.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/pages/sendRecipe_page.dart';
import 'package:cookmaster_front/utils/openFilterDelegate.dart';
import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/http/http_client.dart';
import '../app/data/repositories/ingredient_repository.dart';
import '../app/data/store/ingredient_store.dart';

class HomePage extends StatefulWidget {
  final User? users;
  const HomePage(this.users, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool validateUser = false;

  User? get _users => widget.users;

  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  final CategoryStore storeCategory = CategoryStore(
    repository: CategoryRepository(
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
          chatsState.clear();
          AuthService authService = AuthService();
          await authService.signInWithGoogle();
          Get.to(() => const AuthCheck());
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      storeRecipe.getRecipe();
      storeCategory.getCategory();
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
                      ? await Get.to(() => SendRecipePage(user: widget.users))
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
                      ? await Get.to(() => BagPage(user: widget.users))
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
                  Get.to(() => const PageAstro());
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
                  openFilterDelegate(context, store, "Filtrar");
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40, left: 8.0, right: 8.0),
          child: Column(
            children: [
              CardRecipe(
                store: storeRecipe,
              ),
              Container(
                color: Colors.deepOrange,
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'Categorias',
                    style: TextStyle(
                      fontFamily: 'JacquesFrancois',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTileCategory(
                store: storeCategory,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Ver Mais..."),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(255, 87, 34, 1)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
