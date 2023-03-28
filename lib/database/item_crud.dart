import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallmap_store/model/item.dart';

class ItemCRUD {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference items = firestore.collection('items');

  static Future<String> uploadItemPicture(File file) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    var snapshot = await firebaseStorage
        .ref()
        .child('items_picture/${FirebaseAuth.instance.currentUser!.uid}')
        .putFile(file);

    var pictureURL = await snapshot.ref.getDownloadURL();

    return pictureURL;
  }

  static Future editImage(String id, String url) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    XFile? image;
    File file;

    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {}

    if (image != null) {
      file = File(image.path);
      var snapshot = await firebaseStorage.refFromURL(url).putFile(file);

      var pictureUrl = await snapshot.ref.getDownloadURL();

      items.doc(id).update({'itemPicture': pictureUrl});
    }
  }

  static Future create(Item item) async {
    await items.add(item.toJson());
  }

  static Future edit(String document, Item item) async {
    await items.doc(document).update(item.toJson());
  }

  static Future delete(String doc) async {
    await items.doc(doc).delete();
  }
}
