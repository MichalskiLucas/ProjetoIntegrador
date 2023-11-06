import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/components/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestIngredientPage extends StatefulWidget {
  const SuggestIngredientPage({super.key});

  @override
  State<SuggestIngredientPage> createState() => _SuggestIngredientPageState();
}

class _SuggestIngredientPageState extends State<SuggestIngredientPage> {
  @override
  Widget build(BuildContext context) {
    late String description;

    final IngredientStore storeIngredient = IngredientStore(
      repository: IngredientRepository(
        client: HttpClient(),
      ),
    );

    return Scaffold(
      appBar: AppBarSimple(
        title: 'Cook Master',
        ctx: context,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  description = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Ingrediente",
                  border: UnderlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await storeIngredient.postIngredient(description);
          } catch (e) {
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                'Erro ao fazer Avaliação',
                'Não foi possivel realizar o seu voto',
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.error),
                backgroundColor: Colors.red,
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
