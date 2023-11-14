import 'package:cookmaster_front/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  Future<void> initSplash() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) async {
      Get.to(() => const AuthCheck());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          const Center(
            child: Text(
              'Cook Master',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'JacquesFrancois',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
