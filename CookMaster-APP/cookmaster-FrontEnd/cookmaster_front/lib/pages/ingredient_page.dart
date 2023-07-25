import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:cookmaster_front/store/ingredient_store.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    store.getAllIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBarSearch(
          ctx: context,
          labelText: 'Consultar Ingrediente',
        ),
        body: AnimatedBuilder(
          animation: Listenable.merge(
            [store.isLoading, store.error, store.state],
          ),
          builder: (context, child) {
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

            if (store.state.value.isEmpty) {
              return const Center(
                child: Text('Não possuimos ingredientes'),
              );
            } else {
              return ListView.separated(
                itemBuilder: (_, index) {
                  final item = store.state.value[index];
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
                itemCount: store.state.value.length,
              );
            }
          },
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _CookMasterSearchIngredient(BuildContext context) {
  return const Material(
    child: SizedBox(),
  );
}
