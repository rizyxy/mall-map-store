import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

class ItemImageModel extends StateNotifier<File?> {
  ItemImageModel() : super(null);

  Future setItemImage() async {
    XFile? image;

    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      print(e.toString());
    }

    if (image != null) {
      state = File(image.path);
    }
  }

  void clear() {
    state = null;
  }

  File? getFile() {
    return state;
  }
}

final itemImageModelProvider =
    StateNotifierProvider<ItemImageModel, File?>((ref) => ItemImageModel());
