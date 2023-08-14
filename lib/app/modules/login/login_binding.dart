import 'package:app_write_demo/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/appwrite_provider.dart';
import '../../data/repository/auth_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
     ()=> LoginController(AuthRepository(AppWriteProvider())),
    );
  }
}
