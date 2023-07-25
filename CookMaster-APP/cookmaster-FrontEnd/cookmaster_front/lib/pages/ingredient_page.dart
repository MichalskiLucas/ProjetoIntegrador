import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/store/ingredient_store.dart';
import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';
import '../app/data/models/ingredient_model.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  final IngredientStore store = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.getAllIngredients();
  }

  // Método customizado de filtro
  bool customFilter(String item, String searchText) {
    return item.toLowerCase().contains(searchText.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: _buildSearchField(),
          actions: [
            IconButton(
              onPressed: openFilterDelegate,
              icon: Icon(Icons.filter_list),
            ),
          ],
        ),
        body: Column(
          children: [
            AnimatedBuilder(
              animation: Listenable.merge(
                [store.isLoading, store.error, store.state],
              ),
              builder: (context, child) {
                List<IngredientModel> filteredList;

                if (_searchText.isEmpty) {
                  filteredList = store.state.value;
                } else {
                  filteredList = store.state.value
                      .where(
                          (item) => customFilter(item.descricao, _searchText))
                      .toList();
                }

                if (store.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (store.error.value.isNotEmpty) {
                  return Center(
                    child: Text(store.error.value),
                  );
                }

                if (filteredList.isEmpty) {
                  return const Center(
                    child: Text('Não possuimos ingredientes'),
                  );
                } else {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        final item = filteredList[index];
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(item.descricao),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: filteredList.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Consultar ingrediente',
        border: UnderlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'JacquesFrancois',
        ),
        prefixIcon: Icon(Icons.search, color: Colors.white),
      ),
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'JacquesFrancois',
      ),
    );
  }

  void openFilterDelegate() async {
    List<IngredientModel> ingredientList = store.state.value;
    List<IngredientModel> selectedIngredients = [];

    await FilterListDelegate.show(
      context: context,
      applyButtonText: 'Filtrar',
      list: ingredientList,
      selectedListData: selectedIngredients,
      tileLabel: (IngredientModel? item) {
        if (item == null) return '';
        return item.descricao;
      },
      onItemSearch: (IngredientModel item, String query) {
        // Aqui você pode implementar a pesquisa de itens.
        return item.descricao.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (List<IngredientModel>? list) {
        if (list != null) {
          selectedIngredients = list;
          // Aqui você pode fazer algo com a lista de ingredientes selecionados após o clique no botão "Aplicar".
        }
      },
    );
  }

}
