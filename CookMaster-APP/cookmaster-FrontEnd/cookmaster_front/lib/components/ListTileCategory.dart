import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/pages/recipeSearch_page.dart';
import 'package:cookmaster_front/utils/decodeImageBase64.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileCategory extends StatefulWidget {
  const ListTileCategory({Key? key, required this.store}) : super(key: key);
  final CategoryStore store;

  @override
  _ListTileCategoryState createState() => _ListTileCategoryState();
}

class _ListTileCategoryState extends State<ListTileCategory> {
  CategoryStore get _store => widget.store;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          _store.isLoading,
          _store.error,
          _store.state,
        ],
      ),
      builder: (context, child) {
        if (_store.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_store.error.value.isNotEmpty) {
          return Center(
            child: Text(
              _store.error.value,
            ),
          );
        }

        if (_store.state.value.isEmpty) {
          return const Center(
            child: Text('lista vazia'),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:
                _store.state.value.length >= 5 ? 5 : _store.state.value.length,
            itemBuilder: (_, index) {
              final item = _store.state.value[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () async {
                    //implementar chamada e filtro da receita
                    //await Get.to(const RecipeSearchPage());
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
    );
  }
}
