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
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          SizedBox(
            width: 235,
            height: 58,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.orange.shade900;
                  }
                  return Colors.orange.shade900;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: const BorderSide(color: Colors.orange))),
              ),
              onPressed: () {
                print('Cliquei no elevatedButton');
              },
              child: const Text(
                'Entrar sem Login',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JacquesFrancois',
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 235,
            height: 58,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.shade600;
                  }
                  return Colors.grey.shade600;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: const BorderSide(color: Colors.grey))),
              ),
              onPressed: () {
                print('Cliquei no elevatedButton');
              },
              child: const Text(
                'Entrar com o Google',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JacquesFrancois',
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
