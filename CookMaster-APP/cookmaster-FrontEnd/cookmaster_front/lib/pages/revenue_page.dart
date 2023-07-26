// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenuePage extends StatefulWidget {
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
        body: _CookMasterSearchRevenue(context),
      ),
    );
  }
}

Widget _CookMasterSearchRevenue(BuildContext context) {
  return const Material(
    child: SizedBox(),
  );
}
