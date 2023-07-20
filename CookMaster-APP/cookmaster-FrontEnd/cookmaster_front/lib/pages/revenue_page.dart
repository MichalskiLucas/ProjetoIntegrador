// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({super.key});

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            // ignore: prefer_const_constructors
            leading: Icon(Icons.search),
            title: const TextField(
              decoration: InputDecoration(
                  labelText: 'Consultar Receita',
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
          body: _CookMasterSearchRevenue(context)),
    );
  }
}

Widget _CookMasterSearchRevenue(BuildContext context) {
  return const Material(
    child: SizedBox(),
  );
}
