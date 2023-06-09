import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mallmap_store/controller/product_controller.dart';

import 'package:mallmap_store/model/product.dart';
import 'package:mallmap_store/utils/validator/product_validator.dart';
import 'package:provider/provider.dart';

import 'package:mallmap_store/widgets/widgets.dart';

class CreateItemPage extends StatelessWidget {
  CreateItemPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductController>(context, listen: false)
            .clearProductImage();
        return true;
      },
      child: Scaffold(
        body: MainLayout(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  "Create A Product",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () async =>
                        Provider.of<ProductController>(context, listen: false)
                            .setProductImage(),
                    child: SizedBox(
                      width: 200,
                      height: 250,
                      child: Consumer<ProductController>(
                        builder: (context, controller, _) {
                          if (controller.file == null) {
                            return Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/take-photo.png'),
                                const Text(
                                  "Add A Picture of The Product",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ));
                          } else {
                            return Image.file(controller.file!);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        NormalTextFormField(
                            validator: (name) =>
                                ProductValidator.validateName(name),
                            controller: _nameController,
                            hintText: "Product Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        NormalTextFormField(
                            maxLines: null,
                            validator: (description) =>
                                ProductValidator.validateDescription(
                                    description),
                            controller: _descController,
                            hintText: "Product Description"),
                        const SizedBox(
                          height: 20,
                        ),
                        NormalTextFormField(
                            validator: (price) =>
                                ProductValidator.validatePrice(price),
                            controller: _priceController,
                            hintText: "Product Price")
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        Provider.of<ProductController>(context, listen: false)
                            .createProduct(
                                Provider.of<ProductController>(context,
                                        listen: false)
                                    .file!,
                                Product(
                                    storeId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    pictureUrl: "",
                                    name: _nameController.text,
                                    description: _descController.text,
                                    price:
                                        int.tryParse(_priceController.text)!))
                            .then((value) {
                          Provider.of<ProductController>(context, listen: false)
                              .clearProductImage();
                          Navigator.pop(context);
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: Consumer<ProductController>(
                      builder: (context, controller, child) {
                        if (controller.isLoading) {
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return const Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }
                      },
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
