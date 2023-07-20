import 'package:flutter/material.dart';

class ChefAstroPage extends StatefulWidget {
  const ChefAstroPage({super.key});

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
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
          body: _CookMasterSearchIngredient(context)),
    );
  }
}

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
