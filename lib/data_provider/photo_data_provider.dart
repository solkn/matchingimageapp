import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<String?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  Future<void> uploadImage(String imagePath) async {
    // Implement logic to upload image using http package or other libraries
    // like dio
    // ...
  }
}
