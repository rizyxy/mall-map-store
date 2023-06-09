import 'package:flutter/material.dart';
import 'package:mallmap_store/services/authentication.dart';
import 'package:mallmap_store/widgets/common/logo.dart';
import 'package:mallmap_store/widgets/form/normal_text_form_field.dart';
import 'package:mallmap_store/widgets/layout/main_layout.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Logo(),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Locked Yourself Out?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text("No worries, we've got you covered"),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/padlock.png',
                ),
              ),
              NormalTextFormField(
                  controller: _emailController, hintText: 'Email Address'),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Authentication.resetPassword(_emailController.text).then(
                      (value) => showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>
                              _buildConfirmationDialog(context)));
                },
                child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ]),
      ),
    );
  }

  AlertDialog _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/envelope-mail.png'))),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Email Sent",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Reset password link has been sent to ${_emailController.text}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
              child: Ink(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Got It",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
