
import 'package:app_write_demo/app/data/repository/auth_repository.dart';
import 'package:get/get.dart';

import '../../data/provider/appwrite_provider.dart';
import 'create_employee_controller.dart';

class CreateEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEmployeeController>(
     ()=> CreateEmployeeController(AuthRepository(AppWriteProvider())),
    );
  }
}
