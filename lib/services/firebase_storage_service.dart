import 'package:firebase_storage/firebase_storage.dart';

import '../app/modules/widgets/widget_imports.dart';

class FirebaseStorageService {
  static Future<String> uploadToStorage(
      {required File file,
      required String folderName,
      String? imageName,
      bool showLoader = true}) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            imageName == null
                ? '$folderName/file${DateTime.now().millisecondsSinceEpoch}'
                : '$folderName/$imageName',
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