import 'package:flutter/material.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const TextField(
              decoration: InputDecoration(
                  labelText: 'Consultar Ingrediente',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JacquesFrancois',
                  ),
                  border: UnderlineInputBorder()),
            ),
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
  return const Material(
    child: SizedBox(),
  );
}
