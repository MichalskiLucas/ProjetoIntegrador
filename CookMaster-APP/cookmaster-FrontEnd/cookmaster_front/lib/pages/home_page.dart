import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/bag_page.dart';
import 'package:cookmaster_front/pages/ingredient_page.dart';
import 'package:cookmaster_front/pages/login_page.dart';
import 'package:cookmaster_front/pages/revenue_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.deepOrange),
                accountName: Text('Lucas Michalski'),
                accountEmail: Text('Lucas@gmail.com'),
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
                  await Get.to(() => BagPage());
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
                  await Get.to(() => ChefAstroPage());
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
                  await Get.to(() => LoginPage());
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
                  await Get.to(RevenuePage());
                } else {
                  await Get.to(IngredientPage());
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
