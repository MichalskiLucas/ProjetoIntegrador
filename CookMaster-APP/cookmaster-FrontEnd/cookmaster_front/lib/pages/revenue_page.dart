// ignore_for_file: non_constant_identifier_names

import 'package:cookmaster_front/components/AppBar.dart';
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
          appBar: AppBarSearch(
            ctx: context,
            labelText: 'Consultar Receita',
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
