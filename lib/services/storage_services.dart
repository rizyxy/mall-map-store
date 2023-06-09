import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallmap_store/repository/product_repository.dart';

class StorageServices {
  static Future<String> uploadProductPicture(String id, File file) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    var snapshot = await firebaseStorage
        .ref()
        .child('items_picture')
        .child(id)
        .putFile(file);

    var pictureURL = await snapshot.ref.getDownloadURL();

    ProductRepository.updateField(id, {'pictureUrl': pictureURL});

    return pictureURL;
  }

  static Future overwriteProductImage(String id, String url) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    XFile? image;
    File file;

    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      //
    }

    if (image != null) {
      file = File(image.path);
      var snapshot = await firebaseStorage.refFromURL(url).putFile(file);

      String pictureUrl = await snapshot.ref.getDownloadURL();

      ProductRepository.updateField(id, {'pictureUrl': pictureUrl});
    }
  }
}
