import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/apwrite_constant.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: controller.obx(
        (state) => ListView.separated(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 10,
                color: Colors.grey,
              );
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        '${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeesBucketId}/files/${state[index].image}/view?project=${AppwriteConstants.projectId}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                title: Text(
                  state[index].name,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  state[index].department,
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.moveToEditEmployee(state[index]);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                             controller.deleteEmployee(state[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ]),
              );
            },
            itemCount: state!.length),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(
          child: Text(error!),
        ),
        onEmpty: const Center(
          child: Text('No Employee found'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.moveToCreateEmployee();
        },
      ),
    );
  }
}
