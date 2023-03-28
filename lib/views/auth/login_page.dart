import 'package:flutter/material.dart';
import 'package:mallmap_store/services/authentication.dart';
import 'package:mallmap_store/utils/color_theme.dart';
import 'package:mallmap_store/views/auth/register_page.dart';
import 'package:mallmap_store/views/main/home_page.dart';
import 'package:mallmap_store/widgets/common/logo.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/form/obscure_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Let's Get You Inside",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                NormalTextFormField(
                  hintText: "Email",
                  controller: _emailController,
                ),
                SizedBox(
                  height: 15,
                ),
                ObscureTextFormField(
                  hintText: "Password",
                  controller: _passwordController,
                )
              ],
            )),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => RegisterPage()))),
                  child: Text("Register"),
                ),
                InkWell(
                  child: Text("Forgot Password"),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                Authentication.login(
                        _emailController.text, _passwordController.text)
                    .then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage())));
              },
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
