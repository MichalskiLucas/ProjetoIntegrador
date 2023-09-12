import 'dart:io';

import 'package:cookmaster_front/app/data/repositories/ingredient_repository.dart';
import 'package:cookmaster_front/app/data/store/ingredient_store.dart';
import 'package:cookmaster_front/components/DropdownButtonIngredients.dart';
import 'package:cookmaster_front/components/DropdownButtonUnit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app/data/http/http_client.dart';

class SendRecipePage extends StatefulWidget {
  final User? user;
  const SendRecipePage({Key? key, required this.user}) : super(key: key);

  @override
  State<SendRecipePage> createState() => _SendRecipePageState();
}

class _SendRecipePageState extends State<SendRecipePage> {
  List<CameraDescription> cameras = [];
  String? selectedImagePath;
  String? selectedCategory;
  List<Ingredient> ingredients = [];
  List<Preparation> preparations = [];
  int count = 0;

  final IngredientStore storeIngredients = IngredientStore(
    repository: IngredientRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> openCamera() async {
    if (cameras.isEmpty) {
      print("Nenhuma câmera disponível.");
      return;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraScreen(camera: cameras.first)),
    );
    if (result != null) {
      // Fazer tratamento da imagem tirada
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int ingredientQuantity = 0;
        String ingredientName = '';
        String ingredientUnit = '';
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
                onSelected: (newValue) {
                  setState(() {
                    ingredientName = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownMenuUnitMeansure(
                onSelected: (newValue) {
                  setState(() {
                    ingredientUnit = newValue;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  ingredientQuantity = int.tryParse(value) ?? 0;
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
                      setState(() {
                        ingredients.add(
                          Ingredient(
                            name: ingredientName,
                            quantity: ingredientQuantity,
                            unit: ingredientUnit,
                          ),
                        );
                      });
                      Navigator.pop(context);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String dsPreparation = '';
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
                      setState(() {
                        preparations.add(
                          Preparation(
                              dsPreparation: dsPreparation, step: ++count),
                        );
                      });
                      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Envio Receita",
          style: TextStyle(fontFamily: 'JacquesFrancois'),
        ),
        actions: [],
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
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Título da Receita",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    hint: selectedCategory != null
                        ? Text(selectedCategory!)
                        : const Text("Selecione uma categoria"),
                    value: selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: "Massas",
                        child: Text("Massas"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Carnes",
                        child: Text("Carnes"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Sobremesas",
                        child: Text("Sobremesas"),
                      ),
                    ],
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
                      for (var ingredient in ingredients)
                        ListTile(
                          title: Text(ingredient.name),
                          subtitle:
                              Text('${ingredient.quantity} ${ingredient.unit}'),
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
                      for (var preparation in preparations)
                        ListTile(
                          title: Text("Passo: ${preparation.step}"),
                          subtitle: Text('${preparation.dsPreparation}'),
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
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Enviar Receita")),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Câmera"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  Navigator.pop(context, image.path);
                } catch (e) {
                  print(e);
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
