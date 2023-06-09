import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mallmap_store/repository/store_repository.dart';
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
                const Text(
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
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
                stream: StoreRepository.store
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text("Store Name"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              border: _isEditable
                                  ? const UnderlineInputBorder()
                                  : InputBorder.none),
                          controller: _nameController
                            ..text = snapshot.data!.get('storeName'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Store Location"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              isDense: true,
                              border: _isEditable
                                  ? const UnderlineInputBorder()
                                  : InputBorder.none),
                          controller: _locationController
                            ..text = snapshot.data!.get('storeLocation'),
                        ),
                      ],
                    ));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
            const SizedBox(
              height: 30,
            ),
            Container(
                child: _isEditable
                    ? InkWell(
                        onTap: () async {
                          StoreRepository.edit(
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
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black),
                          child: const Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false));
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
