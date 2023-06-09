// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class ProductImageModel extends StateNotifier<File?> {
//   ProductImageModel() : super(null);

//   Future setItemImage() async {
//     XFile? image;

//     try {
//       image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     } catch (e) {
//       //
//     }

//     if (image != null) {
//       state = File(image.path);
//     }
//   }

//   void clear() {
//     state = null;
//   }

//   File? getFile() {
//     return state;
//   }
// }

// final productImageModelProvider =
//     StateNotifierProvider<ProductImageModel, File?>(
//         (ref) => ProductImageModel());
