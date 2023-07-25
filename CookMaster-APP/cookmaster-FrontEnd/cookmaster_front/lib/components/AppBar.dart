// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarSimple extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext ctx;
  const AppBarSimple({super.key, required this.title, required this.ctx});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset('assets/images/logo.png'),
      centerTitle: true,
      title: Text(title),
      titleTextStyle: const TextStyle(
        fontFamily: 'JacquesFrancois',
        fontSize: 15,
      ),
      backgroundColor: Colors.deepOrange,
      actions: [
        IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String labelText;
  final BuildContext ctx;

  const AppBarSearch({super.key, required this.labelText, required this.ctx});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: TextField(
        decoration: InputDecoration(
            labelText: labelText.isNotEmpty ? labelText : 'Consutlar',
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.white,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'JacquesFrancois',
            ),
            border: const UnderlineInputBorder()),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'JacquesFrancois',
        fontSize: 15,
      ),
      backgroundColor: Colors.deepOrange,
      actions: [
        IconButton(
          onPressed: () async {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
