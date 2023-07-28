import 'package:cookmaster_front/controller/app_controller.dart';
import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

// ignore: use_key_in_widget_constructors
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: const AuthCheck(),
        );
      },
    );
  }
}
