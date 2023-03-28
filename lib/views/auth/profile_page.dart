import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mallmap_store/database/store_crud.dart';
import 'package:mallmap_store/views/auth/login_page.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditable = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Edit Store",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () => setState(() {
                    _isEditable = !_isEditable;
                  }),
                  child: Text(
                    _isEditable ? "Cancel" : "Edit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
                stream: StoreCRUD.store
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Store Name"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              border: _isEditable
                                  ? UnderlineInputBorder()
                                  : InputBorder.none),
                          controller: _nameController
                            ..text = snapshot.data!.get('storeName'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Store Location"),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              border: _isEditable
                                  ? UnderlineInputBorder()
                                  : InputBorder.none),
                          controller: _locationController
                            ..text = snapshot.data!.get('storeLocation'),
                        ),
                      ],
                    ));
                  } else {
                    return CircularProgressIndicator();
                  }
                })),
            SizedBox(
              height: 30,
            ),
            Container(
                child: _isEditable
                    ? InkWell(
                        onTap: () async {
                          StoreCRUD.edit(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  _nameController.text,
                                  _locationController.text)
                              .then((value) {
                            FirebaseAuth.instance.currentUser!
                                .updateDisplayName(_nameController.text);

                            setState(() {
                              _isEditable = false;
                            });
                          });
                        },
                        child: Ink(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black),
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false));
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
