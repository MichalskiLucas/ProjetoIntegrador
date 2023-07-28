// ignore_for_file: file_names

import 'package:cookmaster_front/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChefAstroPage extends StatefulWidget {
  final User? user;
  const ChefAstroPage({super.key, required this.user});

  @override
  State<ChefAstroPage> createState() => _ChefAstroPageState();
}

class _ChefAstroPageState extends State<ChefAstroPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: Image.asset('assets/images/iconChefAstro.png'),
            title: const Text('Chef Astro'),
            titleTextStyle: const TextStyle(
              fontFamily: 'JacquesFrancois',
              fontSize: 15,
            ),
            backgroundColor: Colors.deepOrange,
            actions: [
              IconButton(
                onPressed: () async {
                  await Get.to(
                    () => HomePage(null),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
          body: _CookMasterSearchIngredient(context)),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterSearchIngredient(BuildContext context) {
  return Material(
    child: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 40,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Faça sua pergunta para o chef',
                labelStyle: const TextStyle(
                  fontFamily: 'JacquesFrancois',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                suffixIcon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
