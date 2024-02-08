

import '../app/modules/widgets/widget_imports.dart';

class FirebaseStorageService {
  static Future<String> uploadToStorage(
      {required File file,
      required String folderName,
      String? fileName,
      bool showLoader = true}) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            fileName == null
                ? '$folderName/file${DateTime.now().millisecondsSinceEpoch}'
                : '$folderName/$fileName',
          );

      final UploadTask uploadTask = firebaseStorageRef.putFile(file);

      final TaskSnapshot downloadUrl = await uploadTask;

      String url = await downloadUrl.ref.getDownloadURL();

      return url;
    } on Exception catch (e) {
      showErrorDialog(e.toString());
      return "";
    }
  }
}
