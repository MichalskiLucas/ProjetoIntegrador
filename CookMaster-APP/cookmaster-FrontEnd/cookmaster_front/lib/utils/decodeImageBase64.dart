// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64ImageConverter extends StatelessWidget {
  final String base64Image;
  final double imageSize;

  const Base64ImageConverter({required this.base64Image, this.imageSize = 64.0});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64Image.split(',').last);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.memory(
        bytes,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
