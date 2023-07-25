import 'package:cookmaster_front/components/AppBar.dart';
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
      appBar: AppBarSimple(
        ctx: context,
        title: 'Sacola Cook Master',
        routeReturn: '/bagPage',
      ),
      body: Center(
          //incrementer lista utilizada na sacola
          ),
    ),
  );
}
