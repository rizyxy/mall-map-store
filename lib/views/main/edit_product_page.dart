import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mallmap_store/model/product.dart';
import 'package:mallmap_store/repository/product_repository.dart';
import 'package:mallmap_store/services/storage_services.dart';
import 'package:mallmap_store/utils/validator/product_validator.dart';
import 'package:mallmap_store/widgets/widgets.dart';

class EditItemPage extends StatelessWidget {
  EditItemPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final itemDoc = args['itemDoc'];

    return Scaffold(
      body: MainLayout(
        child: StreamBuilder(
          stream: ProductRepository.products.doc(itemDoc).snapshots(),
          builder: (context, snapshot) {
            try {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // ignore: prefer_const_constructors
                      Text(
                        "Edit Your Product",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async =>
                              StorageServices.overwriteProductImage(
                                  itemDoc, snapshot.data!.get('pictureUrl')),
                          child: SizedBox(
                            width: 200,
                            height: 250,
                            child:
                                Image.network(snapshot.data!.get('pictureUrl')),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                          key: formState,
                          child: Column(
                            children: [
                              NormalTextFormField(
                                  validator: (value) =>
                                      ProductValidator.validateName(value),
                                  controller: _nameController
                                    ..text = snapshot.data!.get('name'),
                                  hintText: "Product Name"),
                              const SizedBox(
                                height: 20,
                              ),
                              NormalTextFormField(
                                  validator: (value) =>
                                      ProductValidator.validateDescription(
                                          value),
                                  maxLines: null,
                                  controller: _descController
                                    ..text = snapshot.data!.get('description'),
                                  hintText: "Product Description"),
                              const SizedBox(
                                height: 20,
                              ),
                              NormalTextFormField(
                                  validator: (value) =>
                                      ProductValidator.validatePrice(value),
                                  controller: _priceController
                                    ..text =
                                        snapshot.data!.get('price').toString(),
                                  hintText: "Product Price")
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          if (formState.currentState!.validate()) {
                            await ProductRepository.edit(
                                    itemDoc,
                                    Product(
                                        storeId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        pictureUrl:
                                            snapshot.data!.get('pictureUrl'),
                                        name: _nameController.text,
                                        description: _descController.text,
                                        price: int.tryParse(
                                            _priceController.text)!))
                                .then((value) => Navigator.pop(context));
                          }
                        },
                        child: Ink(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ProductRepository.delete(itemDoc);
                        },
                        child: const Text(
                          "Delete Product",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            } on Exception {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
