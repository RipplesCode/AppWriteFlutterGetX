import 'dart:io';

import 'package:app_write_demo/app/modules/login/login_controller.dart';
import 'package:app_write_demo/app/modules/employee/create_employee_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CreateEmployeeView extends GetView<CreateEmployeeController> {
  const CreateEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Employee'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Name",
                  ),
                  keyboardType: TextInputType.text,
                  controller: controller.nameEditingController,
                  validator: (value) {
                    return controller.validateName(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Department",
                  ),
                  keyboardType: TextInputType.text,
                  controller: controller.departmentEditingController,
                  validator: (value) {
                    return controller.validateDepartment(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => !controller.isEdit.value
                        ? (controller.imagePath.value == ''
                            ? const Text(
                                'Select image from Gallery',
                                style: TextStyle(fontSize: 20),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(
                                  File(controller.imagePath.value),
                                ),
                              ))
                        : (controller.imagePath.value != ''
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(
                                  File(controller.imagePath.value),
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: controller.imageUrl.value,
                                width: 100,
                                height: 100,
                              ))),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        controller.selectImage();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: context.width),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(14)),
                    ),
                    child: const Text(
                      "Create Employee",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onPressed: () {
                      controller.validateAndSave(
                          name: controller.nameEditingController.text,
                          department:
                              controller.departmentEditingController.text,
                          isEdit: controller.isEdit.value);
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
