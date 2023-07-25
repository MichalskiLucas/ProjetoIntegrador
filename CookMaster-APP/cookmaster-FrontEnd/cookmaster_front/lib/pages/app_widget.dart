import 'package:cookmaster_front/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'createBag.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'astroChef_page.dart';
import 'ingredient_page.dart';
import 'revenue_page.dart';
import 'bag_page.dart';
import 'bagView_page.dart';

// ignore: use_key_in_widget_constructors
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/revenuePage': (context) => const RevenuePage(),
            '/ingredientPage': (context) => const IngredientPage(),
            '/chefAstroPage': (context) => const ChefAstroPage(),
            '/bagPage': (context) => const BagPage(),
            '/createBagPage': (context) => const CreateBagPage(),
            '/bagViewPage': (context) => const BagViewPage(),
          },
        );
      },
    );
  }
}
