import 'package:cookmaster_front/app/data/http/http_client.dart';
import 'package:cookmaster_front/app/data/models/user_model.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/repositories/vote_repository.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:cookmaster_front/app/data/store/vote_store.dart';
import 'package:cookmaster_front/pages/recipe_page.dart';
import 'package:cookmaster_front/utils/decodeImageBase64.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRecipe extends StatefulWidget {
  const CardRecipe({Key? key, required this.store, required this.userStore})
      : super(key: key);
  final RecipeStore store;
  final UserStore userStore;

  @override
  _CardRecipeState createState() => _CardRecipeState();
}

class _CardRecipeState extends State<CardRecipe> {
  RecipeStore get _store => widget.store;
  UserStore get _user => widget.userStore;

  final RecipeStore storeCookingRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  final VoteStore storeVote = VoteStore(
    repository: VoteRepository(
      client: HttpClient(),
    ),
  );

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
          return SingleChildScrollView(
            child: Column(
              children: _store.state.value.map(
                (item) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await storeCookingRecipe.getCookingRecipe(item.id);
                        await storeVote.getVote(_user.state.value.id, item.id);
                        await Get.to(
                          () => RecipePage(
                            storeCookingRecipe: storeCookingRecipe,
                            userStore: _user,
                            voteStore: storeVote,
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Base64ImageConverter(
                                imageWidth: 300,
                                imageHeight: 200,
                                base64Image:
                                    item.image.replaceAll(RegExp(r'\s+'), ''),
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                item.descricao,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'JacquesFrancois',
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        }
      },
    );
  }
}
