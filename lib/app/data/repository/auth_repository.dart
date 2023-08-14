import 'package:app_write_demo/app/data/provider/appwrite_provider.dart';
import 'package:appwrite/appwrite.dart';

import 'package:appwrite/models.dart' as models;

class AuthRepository {
  final AppWriteProvider appWriteProvider;
  AuthRepository(this.appWriteProvider);

  Future<models.Account> signup(Map map) => appWriteProvider.signup(map);
  Future<models.Session> login(Map map) => appWriteProvider.login(map);

  Future<dynamic> logout(String sessionId) =>
      appWriteProvider.logout(sessionId);

  Future<models.File> uploadEmploeeImage(String imagePath) =>
      appWriteProvider.uploadEmploeeImage(imagePath);

  Future<dynamic> deleteEmployeeImage(String fileId) =>
      appWriteProvider.deleteEmployeeImage(fileId);
  Future<models.Document> createEmployee(Map map) =>
      appWriteProvider.createEmployee(map);

  Future<models.DocumentList> getEmployees() => appWriteProvider.getEmployees();

  Future<models.Document> updateEmployee(Map map) =>
      appWriteProvider.updateEmployee(map);


 Future<dynamic> deleteEmployee(Map map) =>
      appWriteProvider.deleteEmployee(map);

   
}
