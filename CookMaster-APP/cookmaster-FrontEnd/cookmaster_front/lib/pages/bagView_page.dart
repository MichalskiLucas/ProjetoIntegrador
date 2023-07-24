import 'package:flutter/material.dart';

class BagViewPage extends StatefulWidget {
  const BagViewPage({super.key});

  @override
  State<BagViewPage> createState() => _BagViewPageState();
}

class _BagViewPageState extends State<BagViewPage> {
  @override
  Widget build(BuildContext context) {
    return _CookMasterBagView(context);
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterBagView(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        centerTitle: true,
        title: const Text('Sacola Cook Master'),
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
          //incrementer lista utilizada na sacola
          ),
    ),
  );
}
