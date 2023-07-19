import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CookMaster'),
          titleTextStyle: const TextStyle(
            fontFamily: 'JacquesFrancois',
            fontSize: 15,
          ),
          backgroundColor: Colors.orange[900],
          leading: IconButton(
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: _listCookMasterHomePage(),
      ),
    );
  }
}

Widget _listCookMasterHomePage() {
  return ListView(
    scrollDirection: Axis.vertical,
  );
}
