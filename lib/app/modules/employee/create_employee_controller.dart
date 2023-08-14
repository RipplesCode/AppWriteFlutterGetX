import 'package:app_write_demo/app/data/repository/auth_repository.dart';
import 'package:app_write_demo/app/modules/utils/full_screen_dialog_loader.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:appwrite/models.dart' as models;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/employee_model.dart';
import '../../routes/app_pages.dart';
import '../utils/apwrite_constant.dart';
import '../utils/custom_snack_bar.dart';

class CreateEmployeeController extends GetxController {
  AuthRepository authRepository;
  CreateEmployeeController(this.authRepository);
//Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //controllers
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController departmentEditingController = TextEditingController();

  // Form validation
  bool isFormValid = false;
  //get storage
  final GetStorage _getStorage = GetStorage();

  var imagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  late String uploadedFileId;

  var isEdit = false.obs;
  var imageUrl = ''.obs;
  late Employee employee;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    if (Get.arguments != null) {
      employee = Get.arguments;
      isEdit.value = true;
      nameEditingController.text = employee.name;
      departmentEditingController.text = employee.department;
      imageUrl.value =
          "${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeesBucketId}/files/${employee.image}/view?project=${AppwriteConstants.projectId}";
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameEditingController.dispose();
    departmentEditingController.dispose();
  }

  void clearTextEditingControllers() {
    nameEditingController.clear();
    departmentEditingController.clear();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Provide valid name";
    }
    return null;
  }

  String? validateDepartment(String value) {
    if (value.isEmpty) {
      return "Provide valid department";
    }
    return null;
  }

  void selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path;
    } else {
      CustomSnackBar.showErrorSnackBar(
          context: Get.context,
          title: "Error",
          message: "Image selection cancelled");
    }
  }

  void validateAndSave(
      {required String name,
      required String department,
      required isEdit}) async {
    isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    } else {
      formKey.currentState!.save();

      if (!isEdit) {
        // Add
        if (imagePath.isNotEmpty) {
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository
                .uploadEmploeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;
              await authRepository.createEmployee({
                "name": name,
                "department": department,
                "createdBy": _getStorage.read("userId"),
                "image": uploadedFileId,
                "createdAt": DateTime.now().toIso8601String()
              }).then((value) {
                FullScreenDialogLoader.cancelDialog();
                CustomSnackBar.showSuccessSnackBar(
                    context: Get.context,
                    title: "Success",
                    message: "Employee Created");
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
                // delete uploaded file
                await authRepository.deleteEmployeeImage(uploadedFileId);
              });
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
        } else {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error", message: "Select image");
        }
      } else {
        //update
        if (imagePath.isNotEmpty) {
          //user has  selected new image
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository
                .uploadEmploeeImage(imagePath.value)
                .then((value) async {
              uploadedFileId = value.$id;
              await authRepository.deleteEmployeeImage(employee.image);
              await authRepository.updateEmployee({
                "name": name,
                "department": department,
                "createdBy": _getStorage.read("userId"),
                "image": uploadedFileId,
                "documentId": employee.documentId,
              }).then((value) {
                FullScreenDialogLoader.cancelDialog();
                CustomSnackBar.showSuccessSnackBar(
                    context: Get.context,
                    title: "Success",
                    message: "Employee Updated");
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
                await authRepository.deleteEmployeeImage(uploadedFileId);
              });
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
        } else {
          // user has not selected new image
          try {
            FullScreenDialogLoader.showDialog();
            await authRepository.updateEmployee({
              "name": name,
              "department": department,
              "createdBy": _getStorage.read("userId"),
              "image": employee.image,
              "documentId": employee.documentId,
            }).then((value) {
              FullScreenDialogLoader.cancelDialog();
              CustomSnackBar.showSuccessSnackBar(
                  context: Get.context,
                  title: "Success",
                  message: "Employee Updated");
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
      }
    }
  }
}
