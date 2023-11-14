// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names, avoid_init_to_null

import 'dart:convert';
import 'dart:io';

import 'package:cookmaster_front/app/data/models/category_model.dart';
import 'package:cookmaster_front/app/data/models/ingredient_model.dart';
import 'package:cookmaster_front/app/data/models/preparation_model.dart';
import 'package:cookmaster_front/app/data/models/recipeSend_model.dart';
import 'package:cookmaster_front/app/data/models/unitMeansure_model.dart';
import 'package:cookmaster_front/app/data/repositories/category_repository.dart';
import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/repositories/recipe_repository.dart';
import 'package:cookmaster_front/app/data/repositories/unitMeansure_repository.dart';
import 'package:cookmaster_front/app/data/store/category_store.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/app/data/store/recipe_store.dart';
import 'package:cookmaster_front/app/data/store/unitMeasure_store.dart';
import 'package:cookmaster_front/components/CameraScreen.dart';
import 'package:cookmaster_front/components/DropdownButtonIngredients.dart';
import 'package:cookmaster_front/components/DropdownButtonUnit.dart';
import 'package:cookmaster_front/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app/data/http/http_client.dart';

class SendRecipeSearchPage extends StatefulWidget {
  final User? user;
  final int idUser;
  const SendRecipeSearchPage(
      {Key? key, required this.user, required this.idUser})
      : super(key: key);

  @override
  State<SendRecipeSearchPage> createState() => _SendRecipeSearchPageState();
}

class _SendRecipeSearchPageState extends State<SendRecipeSearchPage> {
  List<CameraDescription> cameras = [];
  String? selectedImagePath;
  String? imageSendBase64;
  CategoryModel? selectedCategory;
  List<IngredientModel>? ingredients = [];
  List<PreparationModel>? preparations = [];
  List<CategoryModel> categoryList = [];
  List<IngredientModel> ingredientList = [];
  List<UnitMeansureModel> listUnitMeansure = [];
  late Map<int, String> categoryMap = {};
  int count = 0;

  int get _idUser => widget.idUser;
  User? get _user => widget.user;

  final UnitMeansureStore storeUnitMeansure = UnitMeansureStore(
    repository: UnitMeansureRepository(
      client: HttpClient(),
    ),
  );

  final CategoryStore storeCategory = CategoryStore(
    repository: CategoryRepository(
      client: HttpClient(),
    ),
  );

  final IngredientStore storeIngredient = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  final RecipeStore storeRecipe = RecipeStore(
    repository: RecipeRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    loadingCategory();
    loadingIngredient();
    loadingUnitMeansure();
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  Future<List<UnitMeansureModel>> loadingUnitMeansure() async {
    try {
      await storeUnitMeansure.getUnitMeansure();
      listUnitMeansure = storeUnitMeansure.state.value;
      setState(() {});
      if (listUnitMeansure.isNotEmpty) {
        return listUnitMeansure;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<IngredientModel>> loadingIngredient() async {
    try {
      await storeIngredient.getAllIngredients();
      ingredientList = storeIngredient.state.value;
      setState(() {});
      if (ingredientList.isNotEmpty) {
        return ingredientList;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<List<CategoryModel>> loadingCategory() async {
    try {
      await storeCategory.getCategory();
      categoryList = storeCategory.state.value;
      setState(() {
        null;
      });
      if (categoryList.isNotEmpty) {
        return categoryList;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);
      setState(
        () {
          imageSendBase64 = base64String;
          selectedImagePath = pickedFile.path;
        },
      );
    }
  }

  Future<void> openCamera() async {
    if (cameras.isEmpty) {
      return;
    }

    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(camera: cameras.first),
        ),
      );

      if (result != null) {
        final file = File(result);
        final bytes = await file.readAsBytes();
        final base64String = base64Encode(bytes);

        setState(() {
          imageSendBase64 = base64String;
          selectedImagePath = result;
        });
      }
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Erro',
          'Erro ao abrir a câmera: $e',
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> checkAndRequestPermissions() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      var cameraPermissionStatus = await Permission.camera.request();
      if (!cameraPermissionStatus.isGranted) {
        return;
      }
    }

    var galleryStatus = await Permission.photos.status;
    if (!galleryStatus.isGranted) {
      var galleryPermissionStatus = await Permission.photos.request();
      if (!galleryPermissionStatus.isGranted) {
        return;
      }
    }
  }

  void _openImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Escolha uma opção",
            style: TextStyle(fontFamily: "JacquesFrancois"),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  checkAndRequestPermissions();
                  openGallery();
                },
                child: const Text(
                  "Galeria",
                  style: TextStyle(
                    fontFamily: "JacquesFrancois",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await checkAndRequestPermissions();
                  await openCamera();
                },
                child: const Text(
                  "Câmera",
                  style: TextStyle(
                    fontFamily: "JacquesFrancois",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addIngredient() {
    double ingredientQuantity = 0.0;
    IngredientModel? ingredientName;
    UnitMeansureModel? ingredientUnit = null;

    String validaIngrediente() {
      if (ingredientName?.id == null) {
        return "Selecione um ingrediente";
      }

      if (ingredientQuantity.isEqual(0.0)) {
        return "Digite a quantidade";
      }

      if (ingredientUnit == null) {
        return "Selecione uma unidade de medida";
      }

      return "";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Adicionar Ingrediente",
              style: TextStyle(fontFamily: "JacquesFrancois"),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownMenuIngredient(
                listIngredient: ingredientList,
                onSelected: (newValue) {
                  setState(() {
                    ingredientName = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownMenuUnitMeansure(
                listUnitMeansure: listUnitMeansure,
                onSelected: (newValue) {
                  setState(
                    () {
                      ingredientUnit = newValue;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  ingredientQuantity = double.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantidade",
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Voltar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final String validaIngredient = validaIngrediente();

                      if (validaIngredient == "") {
                        setState(
                          () {
                            ingredients?.add(
                              IngredientModel(
                                id: ingredientName!.id,
                                descricao: ingredientName!.descricao.toString(),
                                qtdIngrediente: ingredientQuantity,
                                unMedida: ingredientUnit!.descricao.toString(),
                                unMedidaStr: ingredientUnit!.value.toString(),
                              ),
                            );
                          },
                        );
                        Navigator.pop(context);
                      } else {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            'Atenção',
                            validaIngredient,
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(Icons.warning),
                            backgroundColor: Colors.amber,
                          );
                        }
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addPreparation() {
    String dsPreparation = '';

    String validaPreparation() {
      if (dsPreparation == '') {
        return "Digite o passo";
      }

      return "";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Adicionar Passo",
              style: TextStyle(fontFamily: "JacquesFrancois"),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  dsPreparation = value;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Passo",
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Voltar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final String valida = validaPreparation();

                      if (valida == "") {
                        setState(
                          () {
                            preparations?.add(
                              PreparationModel(
                                descricao: dsPreparation,
                                id: ++count,
                              ),
                            );
                          },
                        );
                        Navigator.pop(context);
                      } else {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            'Atenção',
                            valida,
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(Icons.warning),
                            backgroundColor: Colors.amber,
                          );
                        }
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController tituloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Envio Receita",
          style: TextStyle(fontFamily: 'JacquesFrancois'),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (selectedImagePath == null)
                  ElevatedButton(
                    onPressed: () {
                      _openImagePickerDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt),
                          SizedBox(height: 20),
                          Text(
                            "Envie uma foto da receita",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "JacquesFrancois",
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                if (selectedImagePath != null)
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(selectedImagePath!),
                            width: MediaQuery.of(context).size.width - 20,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _openImagePickerDialog();
                        },
                        child: const Text("Trocar Imagem"),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: "Título da Receita",
                    border: UnderlineInputBorder(),
                    counterText: '',
                  ),
                  maxLength: 50,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<CategoryModel>(
                    hint: selectedCategory != null
                        ? Text(selectedCategory.toString())
                        : const Text("Selecione uma categoria"),
                    value: selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    items: categoryList.map((CategoryModel value) {
                      return DropdownMenuItem<CategoryModel>(
                        value: value,
                        child: Text(value.descricao),
                      );
                    }).toList(),
                    iconSize: 24,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Ingredientes",
                        style: TextStyle(
                          fontFamily: "JacquesFrancois",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var ingredient in ingredients!)
                        ListTile(
                          title: Text(ingredient.descricao.toString()),
                          subtitle: Text(
                              '${ingredient.qtdIngrediente?.toStringAsFixed(0) ?? '0'} ${ingredient.unMedida}'),
                        ),
                      ElevatedButton(
                        onPressed: _addIngredient,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(120, 40),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.deepOrange),
                            Text(
                              "Adicionar Ingrediente",
                              style: TextStyle(
                                  fontFamily: "JacquesFrancois",
                                  color: Colors.deepOrange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Modo de Preparo",
                        style: TextStyle(
                          fontFamily: "JacquesFrancois",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var preparation in preparations!)
                        ListTile(
                          title: Text("Passo: ${preparation.id}"),
                          subtitle: Text('${preparation.descricao}'),
                        ),
                      ElevatedButton(
                        onPressed: _addPreparation,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(120, 40),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.deepOrange),
                            Text(
                              "Adicionar Passo",
                              style: TextStyle(
                                  fontFamily: "JacquesFrancois",
                                  color: Colors.deepOrange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String valida = validaPost();

                      if (valida == "") {
                        RecipeSendModel recipeSendModel = RecipeSendModel(
                          ativo: false,
                          descricao: tituloController.text,
                          image: imageSendBase64,
                          voto: 0,
                          categoriaId: selectedCategory!.id,
                          usuarioId: _idUser,
                          ingredientes: ingredients,
                          preparos: preparations,
                        );

                        await storeRecipe.postRecipe(recipeSendModel);
                      } else {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            'Atenção',
                            valida,
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(Icons.warning),
                            backgroundColor: Colors.amber,
                          );
                        }
                      }

                      if (storeRecipe.statePost.value == 200) {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            'Receita Cadastrada',
                            'Obrigado por enviar sua receita!',
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(Icons.verified),
                            backgroundColor: Colors.green,
                          );
                        }
                        Get.to(() => HomePage(_user));
                      } else {
                        if (!Get.isSnackbarOpen) {
                          Get.snackbar(
                            'Erro',
                            'Ocorreu um erro ao cadastrar sua receita',
                            snackPosition: SnackPosition.BOTTOM,
                            icon: const Icon(Icons.error),
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: const Text("Enviar Receita"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String validaPost() {
    if (selectedCategory?.id == null) {
      return "É necessário informar uma categoria";
    }

    if (tituloController.text.isEmpty) {
      return "É necessário informar o titulo da receita";
    }

    if (imageSendBase64 == null) {
      return "É necessário informar uma imagem";
    }

    if (ingredients!.isEmpty) {
      return "É necessário informar ao menos um ingrediente";
    }

    if (preparations!.isEmpty) {
      return "É necessário informar ao menos um preparo";
    }

    return "";
  }
}

class Ingredient {
  final String name;
  final int quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}

class Preparation {
  final String dsPreparation;
  final int step;

  Preparation({required this.dsPreparation, required this.step});
}
