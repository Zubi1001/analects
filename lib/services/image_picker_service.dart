import '../app/modules/widgets/widget_imports.dart';

class ImagePickerService {
  static final picker = ImagePicker();
  static Future<File?> getImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        log("got the file it is ${pickedFile.path}");

        return File(pickedFile.path);
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      log(e.toString());
      // showErrorSnackBar(error: e.toString());
      return null;
    }
  }

  static Future<File?> getImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      log(e.toString());
      // showErrorSnackBar(error: e.toString());
      return null;
    }
  }

  // static Future<Uint8List?> getImageForWeb() async {
  //   try {
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       return await pickedFile.readAsBytes();
  //     } else {
  //       return null;
  //     }
  //   } on PlatformException catch (e) {
  //     log(e.toString());
  //     // showErrorSnackBar(error: e.toString());
  //     return null;
  //   }
  // }

}