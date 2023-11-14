// ignore_for_file: file_names

import 'package:flutter/material.dart';

PopupMenuItem buildPopUpMenuItem(String title, IconData icon, String value) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'JacquesFrancois',
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
