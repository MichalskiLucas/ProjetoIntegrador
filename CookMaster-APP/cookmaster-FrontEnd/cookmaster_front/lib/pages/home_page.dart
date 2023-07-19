import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                'Entrar sem login',
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
            child: ElevatedButton.icon(
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
              icon: Image.asset('assets/images/logoGoogle.png'),
              label: const Text(
                "Entrar com o google",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'JacquesFrancois',
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
