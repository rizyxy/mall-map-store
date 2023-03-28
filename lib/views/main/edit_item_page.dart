import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mallmap_store/database/item_crud.dart';
import 'package:mallmap_store/model/item.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class EditItemPage extends ConsumerWidget {
  EditItemPage({super.key, required this.itemDoc});

  String itemDoc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: MainLayout(
        child: StreamBuilder(
          stream: ItemCRUD.items.doc(itemDoc).snapshots(),
          builder: (context, snapshot) {
            try {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Edit Your Item",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async => ItemCRUD.editImage(
                              snapshot.data!.id,
                              snapshot.data!.get('itemPicture')),
                          child: Container(
                            width: 200,
                            height: 250,
                            child: Image.network(
                                snapshot.data!.get('itemPicture')),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                          child: Column(
                        children: [
                          NormalTextFormField(
                              controller: _nameController
                                ..text = snapshot.data!.get('itemName'),
                              hintText: "Item Name"),
                          SizedBox(
                            height: 20,
                          ),
                          NormalTextFormField(
                              controller: _descController
                                ..text = snapshot.data!.get('itemDesc'),
                              hintText: "Item Name"),
                          SizedBox(
                            height: 20,
                          ),
                          NormalTextFormField(
                              controller: _priceController
                                ..text =
                                    snapshot.data!.get('itemPrice').toString(),
                              hintText: "Item Name")
                        ],
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          ItemCRUD.edit(
                              snapshot.data!.id,
                              Item(
                                  storeId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  itemPictureURL:
                                      snapshot.data!.get('itemPicture'),
                                  itemName: _nameController.text,
                                  itemDescription: _descController.text,
                                  itemPrice: int.tryParse(_priceController.text)
                                      as int));
                        },
                        child: Ink(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ItemCRUD.delete(snapshot.data!.id);
                        },
                        child: Text(
                          "Delete Item",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            } on Exception catch (e) {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _buildEdit(
      AsyncSnapshot<DocumentSnapshot<Object?>> snapshot, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Edit Your Item",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: InkWell(
              onTap: () async => ItemCRUD.editImage(
                  snapshot.data!.id, snapshot.data!.get('itemPicture')),
              child: Container(
                width: 200,
                height: 250,
                child: Image.network(snapshot.data!.get('itemPicture')),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Form(
              child: Column(
            children: [
              NormalTextFormField(
                  controller: _nameController
                    ..text = snapshot.data!.get('itemName'),
                  hintText: "Item Name"),
              SizedBox(
                height: 20,
              ),
              NormalTextFormField(
                  controller: _descController
                    ..text = snapshot.data!.get('itemDesc'),
                  hintText: "Item Name"),
              SizedBox(
                height: 20,
              ),
              NormalTextFormField(
                  controller: _priceController
                    ..text = snapshot.data!.get('itemPrice').toString(),
                  hintText: "Item Name")
            ],
          )),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              ItemCRUD.edit(
                  snapshot.data!.id,
                  Item(
                      storeId: FirebaseAuth.instance.currentUser!.uid,
                      itemPictureURL: snapshot.data!.get('itemPicture'),
                      itemName: _nameController.text,
                      itemDescription: _descController.text,
                      itemPrice: int.tryParse(_priceController.text) as int));
            },
            child: Ink(
              padding: EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              ItemCRUD.delete(snapshot.data!.id)
                  .then((value) => Navigator.pop(context));
            },
            child: Text(
              "Delete Item",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
