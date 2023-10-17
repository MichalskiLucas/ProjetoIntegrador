import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/pages/recipeSearch_page.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:flutter/material.dart';
import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:get/get.dart';
import '../utils/decodeImageBase64.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

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
    super.initState();
    store.getCategory();
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
            return const Center(
              child: CircularProgressIndicator(),
            );
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
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      //implementar chamada e filtro da receita
                      await Get.to(const RecipeSearchPage());
                    },
                    leading: Base64ImageConverter(
                      base64Image: item.image.replaceAll(RegExp(r'\s+'), ''),
                    ),
                    trailing:
                        const Icon(Icons.arrow_forward, color: Colors.black),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.descricao,
                      style: const TextStyle(
                        fontFamily: 'JacquesFrancois',
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
