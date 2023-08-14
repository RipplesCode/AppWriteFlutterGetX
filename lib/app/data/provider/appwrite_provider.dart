import 'package:app_write_demo/app/modules/utils/apwrite_constant.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppWriteProvider {
  Client client = Client();
  Account? account;
  Storage? storage;
  Databases? databases;
 
  AppWriteProvider() {
    client
        .setEndpoint(AppwriteConstants.endPoint)
        .setProject(AppwriteConstants.projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    storage = Storage(client);
    databases = Databases(client);
   
  }

  Future<models.Account> signup(Map map) async {
    final response = account!.create(
        userId: map["userId"],
        email: map["email"],
        password: map["password"],
        name: map["name"]);

    return response;
  }

  Future<models.Session> login(Map map) async {
    final response = account!.createEmailSession(
      email: map["email"],
      password: map["password"],
    );
    return response;
  }

  Future<dynamic> logout(String sessionId) async {
    final response = account!.deleteSession(sessionId: sessionId);

    return response;
  }

  Future<models.File> uploadEmploeeImage(String imagePath) async {
    String fileName =
        "${DateTime.now().millisecondsSinceEpoch}.${imagePath.split(".").last}";
    final response = storage!.createFile(
      bucketId: AppwriteConstants.employeesBucketId,
      fileId: ID.unique(),
      file: InputFile(path: imagePath, filename: fileName),
    );
    return response;
  }

  Future<dynamic> deleteEmployeeImage(String fileId) async {
    final response = storage!.deleteFile(
        bucketId: AppwriteConstants.employeesBucketId, fileId: fileId);

    return response;
  }

  Future<models.Document> createEmployee(Map map) async {
    final response = databases!.createDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeesCollectionId,
        documentId: ID.unique(),
        data: {
          "name": map["name"],
          "department": map["department"],
          "createdBy": map["createdBy"],
          "image": map["image"],
          "createdAt": map["createdAt"]
        });

    return response;
  }

  Future<models.DocumentList> getEmployees() async {
    final response = databases!.listDocuments(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeesCollectionId,
        queries: [Query.orderDesc("createdAt")]);

    return response;
  }

  Future<models.Document> updateEmployee(Map map) async {
    final response = databases!.updateDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeesCollectionId,
        documentId: map["documentId"],
        data: {
          "name": map["name"],
          "department": map["department"],
          "createdBy": map["createdBy"],
          "image": map["image"],
        });

    return response;
  }

  Future<dynamic> deleteEmployee(Map map) async {
    final response = databases!.deleteDocument(
      databaseId: AppwriteConstants.dbId,
      collectionId: AppwriteConstants.employeesCollectionId,
      documentId: map["documentId"],
    );

    return response;
  }

 
}
