import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mallmap_store/database/item_crud.dart';
import 'package:mallmap_store/model/item.dart';
import 'package:mallmap_store/services/item_creation_validator.dart';
import 'package:mallmap_store/states/item_image.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class CreateItemPage extends ConsumerWidget {
  CreateItemPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        ref.read(itemImageModelProvider.notifier).clear();
        return true;
      },
      child: Scaffold(
        body: MainLayout(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Create An Item",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () async => ref
                        .read(itemImageModelProvider.notifier)
                        .setItemImage(),
                    child: Container(
                      width: 200,
                      height: 250,
                      child: ref.watch(itemImageModelProvider) == null
                          ? Center(
                              child: Text("Add A Picture of Your Item"),
                            )
                          : Image.file(ref
                              .read(itemImageModelProvider.notifier)
                              .getFile() as File),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    NormalTextFormField(
                        controller: _nameController, hintText: "Item Name"),
                    SizedBox(
                      height: 20,
                    ),
                    NormalTextFormField(
                        controller: _descController,
                        hintText: "Item Description"),
                    SizedBox(
                      height: 20,
                    ),
                    NormalTextFormField(
                        controller: _priceController, hintText: "Item Price")
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (ItemCreationValidator.isValid(
                        ref.read(itemImageModelProvider.notifier).getFile(),
                        _nameController.text,
                        int.tryParse(_priceController.text),
                        _descController.text)) {
                      try {
                        ItemCRUD.uploadItemPicture(ref
                                .read(itemImageModelProvider.notifier)
                                .getFile() as File)
                            .then((itemPictureURL) => ItemCRUD.create(Item(
                                storeId: FirebaseAuth.instance.currentUser!.uid,
                                itemPictureURL: itemPictureURL,
                                itemName: _nameController.text,
                                itemDescription: _descController.text,
                                itemPrice: int.tryParse(_priceController.text)
                                    as int)))
                            .then((value) => Navigator.pop(context));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
