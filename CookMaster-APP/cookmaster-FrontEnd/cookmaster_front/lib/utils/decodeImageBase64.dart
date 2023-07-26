// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64ImageConverter extends StatelessWidget {
  final String base64Image;

  const Base64ImageConverter({required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // Decodifica a string base64 para bytes
    Uint8List bytes = base64Decode(base64Image.split(',').last);

    // Cria a imagem usando os bytes decodificados
    Image image = Image.memory(bytes);

    // Retorna a imagem para ser exibida
    return image;
  }
}
