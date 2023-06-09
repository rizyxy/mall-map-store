import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallmap_store/model/product.dart';
import 'package:mallmap_store/repository/product_repository.dart';

class ProductController extends ChangeNotifier {
  File? _file;
  bool _isLoading = false;

  File? get file => _file;
  bool get isLoading => _isLoading;

  Future<void> createProduct(File file, Product product) async {
    try {
      _isLoading = true;
      notifyListeners();

      await ProductRepository.create(file, product);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setProductImage() async {
    XFile? imageFile;

    try {
      imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageFile != null) {
        _file = File(imageFile.path);
      }
    } finally {
      notifyListeners();
    }
  }

  void clearProductImage() {
    _file = null;
    notifyListeners();
  }
}
