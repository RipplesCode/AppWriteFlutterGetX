import 'package:app_write_demo/app/data/repository/auth_repository.dart';
import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:appwrite/models.dart' as models;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/employee_model.dart';
import '../../routes/app_pages.dart';
import '../utils/custom_snack_bar.dart';
import '../utils/full_screen_dialog_loader.dart';

class HomeController extends GetxController with StateMixin<List<Employee>> {
  AuthRepository authRepository;
  HomeController(this.authRepository);
  late List<Employee> employeeList = [];

  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getEmployee();
   
  }

  @override
  void onClose() {
    super.onClose();
   
  }

  logout() async {
    try {
      FullScreenDialogLoader.showDialog();
      await authRepository.logout(_getStorage.read("sessionId")).then((value) {
        FullScreenDialogLoader.cancelDialog();
        Get.offAllNamed(Routes.login);
      }).catchError((error) {
        FullScreenDialogLoader.cancelDialog();
        if (error is AppwriteException) {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: error.response['message']);
        } else {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: "Something went wrong");
        }
      });
    } catch (e) {
      FullScreenDialogLoader.cancelDialog();

      CustomSnackBar.showErrorSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong");
    }
  }

  moveToCreateEmployee() {
    Get.toNamed(Routes.createEmployee);
  }

  moveToEditEmployee(Employee employee) {
    Get.toNamed(Routes.createEmployee, arguments: employee);
  }

  deleteEmployee(Employee employee) async {
    try {
      FullScreenDialogLoader.showDialog();
      await authRepository.deleteEmployee({
        "documentId": employee.documentId,
      }).then((value) async {
        await authRepository.deleteEmployeeImage(employee.image);
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: "Success",
            message: "Employee Deleted");
        Get.offAllNamed(Routes.home);
      }).catchError((error) async {
        FullScreenDialogLoader.cancelDialog();
        if (error is AppwriteException) {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: error.response['message']);
        } else {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: "Error",
              message: "Something went wrong");
        }
      });
    } catch (e) {
      FullScreenDialogLoader.cancelDialog();
      CustomSnackBar.showErrorSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong");
    }
  }

  getEmployee() async {
    try {
      change(null, status: RxStatus.loading());
      await authRepository.getEmployees().then((value) {
        Map<String, dynamic> data = value.toMap();
        List d = data['documents'].toList();
        employeeList = d
            .map(
              (e) => Employee.fromMap(e['data']),
            )
            .toList();

        change(employeeList, status: RxStatus.success());
      }).catchError((error) {
        if (error is AppwriteException) {
          change(null, status: RxStatus.error(error.response['message']));
        } else {
          change(null, status: RxStatus.error("Something went wrong"));
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

 
}
