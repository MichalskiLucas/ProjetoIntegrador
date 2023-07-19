import 'package:cookmaster_front/controller/app_controller.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.orange.shade800,
                    secondary: Colors.grey.shade600)),
            initialRoute: '/',
            routes: {
              '/': (context) => const LoginPage(),
              '/home': (context) => const HomePage(),
            },
          );
        });
  }
}
