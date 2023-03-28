import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mallmap_store/services/authentication.dart';
import 'package:mallmap_store/services/authentication_validator.dart';
import 'package:mallmap_store/views/auth/login_page.dart';
import 'package:mallmap_store/widgets/common/logo.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/form/obscure_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeLocationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Logo(),
            SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Register Your Store Here",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 30,
                ),
                NormalTextFormField(
                    hintText: "Store Name", controller: _storeNameController),
                SizedBox(
                  height: 15,
                ),
                NormalTextFormField(
                    controller: _storeLocationController,
                    hintText: "Store Location"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your store location is on what floor your store is located",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                ),
                NormalTextFormField(
                    controller: _emailController, hintText: "Email Address"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "It's advised that you should not use a personal email for this",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 15,
                ),
                ObscureTextFormField(
                    hintText: "Password", controller: _passwordController),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your password must be 8 characters long minimum containing lowercase, uppercase, number, and symbols",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (AuthenticationValidator.isValid(
                    _storeNameController.text,
                    _storeLocationController.text,
                    _emailController.text,
                    _passwordController.text)) {
                  Authentication.register(
                          _storeNameController.text,
                          _storeLocationController.text,
                          _emailController.text,
                          _passwordController.text)
                      .then((value) => showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return _buildConfirmationDialog(context);
                          }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Store identity is not valid"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already registered a store?"),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Login here",
                  style: TextStyle(color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  AlertDialog _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Icon(
              Icons.check_circle_outline_sharp,
              color: Colors.green,
              size: 60,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Store Registered",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Store is added to our database. You may now login to MallMap",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              child: Ink(
                padding: EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
