// ignore_for_file: file_names

import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBarSimple(
            title: 'Cook Master',
            ctx: context,
            routeReturn: '/home',
          ),
          body: _CookMasterBag(context)),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterBag(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 30),
      const SizedBox(
        child: Text(
          'Você ja possui uma sacola, deseja criar uma nova?',
          style: TextStyle(fontFamily: 'JacquesFrancois', fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        child: Image.asset('assets/images/logo.png'),
      ),
      const SizedBox(
        child: Text(
          'Cook Master',
          style: TextStyle(
            fontFamily: 'JacquesFrancois',
            fontSize: 25,
          ),
        ),
      ),
      const SizedBox(height: 250),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.deepOrange;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/bagViewPage');
                },
                child: const Text(
                  'Visualizar',
                  style: TextStyle(
                    fontFamily: 'JacquesFrancois',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 95),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.deepOrange;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: const BorderSide(color: Colors.deepOrange))),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/createBagPage');
                },
                child: const Text(
                  'Criar',
                  style: TextStyle(
                    fontFamily: 'JacquesFrancois',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
