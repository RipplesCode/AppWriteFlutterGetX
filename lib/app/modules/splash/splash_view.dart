import 'package:app_write_demo/app/modules/login/login_controller.dart';
import 'package:app_write_demo/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 100,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
