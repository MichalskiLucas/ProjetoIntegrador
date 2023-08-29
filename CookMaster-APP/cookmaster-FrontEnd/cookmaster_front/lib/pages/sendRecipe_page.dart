import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class SendRecipePage extends StatefulWidget {
  final User? user;
  const SendRecipePage({Key? key, required this.user}) : super(key: key);

  @override
  State<SendRecipePage> createState() => _SendRecipePageState();
}

class _SendRecipePageState extends State<SendRecipePage> {
  List<CameraDescription> cameras = [];

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
      // Fazer tratamento da imagem selecionada
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Envio Receita",
          style: TextStyle(fontFamily: 'JacquesFrancois'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text(
                          "Escolha uma opção",
                          style: TextStyle(fontFamily: "JacquesFrancois"),
                        ),
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
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
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
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
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
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            Navigator.pop(context, image.path);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
