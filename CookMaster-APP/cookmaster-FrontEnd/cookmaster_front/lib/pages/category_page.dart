import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/store/category_store.dart';
import 'package:flutter/material.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  final CategoryStore store = CategoryStore(
    repository: CategoryRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        ctx: context,
        title: 'Categorias',
      ),
      body: AnimatedBuilder(
        animation:
            Listenable.merge([store.isLoading, store.error, store.state]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return const Center(
              child: Text('lista vazia'),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Base64ImageConverter(
                          base64Image:
                              item.image.replaceAll(RegExp(r'\s+'), ''),
                        )),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.descricao),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Base64ImageConverter extends StatelessWidget {
  final String base64Image;

  Base64ImageConverter({required this.base64Image});

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