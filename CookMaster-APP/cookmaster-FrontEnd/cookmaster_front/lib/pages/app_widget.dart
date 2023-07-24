import 'package:cookmaster_front/controller/app_controller.dart';
import 'package:cookmaster_front/pages/astroChef_page.dart';
import 'package:cookmaster_front/pages/ingredient_page.dart';
import 'package:cookmaster_front/pages/revenue_page.dart';
import 'package:cookmaster_front/pages/bag_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

// ignore: use_key_in_widget_constructors
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return MaterialApp(
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
            },
          );
        });
  }
}
