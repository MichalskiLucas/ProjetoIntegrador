// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text("Câmera"),
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
                  if (!Get.isSnackbarOpen) {
                    Get.snackbar(
                      'Erro',
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Icons.error),
                      backgroundColor: Colors.red,
                    );
                  }
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(_controller),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao inicializar a câmera.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
