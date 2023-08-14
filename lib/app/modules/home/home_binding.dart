import 'package:app_write_demo/app/data/provider/appwrite_provider.dart';
import 'package:app_write_demo/app/data/repository/auth_repository.dart';
import 'package:get/get.dart';

import 'home_controller.dart';





class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
     HomeController(AuthRepository(AppWriteProvider())),
    );
   
     
  }
}
