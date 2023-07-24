import 'package:cookmaster_front/components/ButtonFinishBag.dart';
import 'package:flutter/material.dart';

class CreateBagPage extends StatefulWidget {
  const CreateBagPage({super.key});

  @override
  State<CreateBagPage> createState() => _CreateBagPageState();
}

class _CreateBagPageState extends State<CreateBagPage> {
  @override
  Widget build(BuildContext context) {
    return _CookMasterSearchIngredient(context);
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterSearchIngredient(BuildContext context) {
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
      body: const Center(
        child: ButtonFinishBag(),
      ),
    ),
  );
}
