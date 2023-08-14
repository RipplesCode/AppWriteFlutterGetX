import 'package:app_write_demo/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/appwrite_provider.dart';
import '../../data/repository/auth_repository.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
SplashController(),
    );
  }
}
