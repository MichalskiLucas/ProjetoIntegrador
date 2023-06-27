import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[900],
        ),
        body: _listCookMasterLogin(),
      ),
    );
  }
}

Widget _listCookMasterLogin() {
  return ListView(
    scrollDirection: Axis.vertical,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: 250,
            height: 250,
            child: Image.asset('assets/images/logo.png'),
          ),
          const Text(
            "Cook Master",
            style: TextStyle(fontSize: 25, fontFamily: 'JacquesFrancois'),
          )
        ],
      )
    ],
  );
}
