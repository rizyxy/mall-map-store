import 'package:flutter/material.dart';
import 'package:mallmap_store/controller/authentication_controller.dart';
import 'package:mallmap_store/utils/validator/null_validator.dart';
import 'package:mallmap_store/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Logo(),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      "Let's Get You Inside",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    NormalTextFormField(
                      hintText: "Email",
                      validator: (value) =>
                          NullValidator.nullValidator('Email', value),
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ObscureTextFormField(
                      validator: (value) =>
                          NullValidator.nullValidator('Password', value),
                      hintText: "Password",
                      controller: _passwordController,
                    )
                  ],
                )),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Register"),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/forgot'),
                  child: const Text("Forgot Password"),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (formState.currentState!.validate()) {
                  Provider.of<AuthenticationController>(context, listen: false)
                      .login(_emailController.text, _passwordController.text)
                      .then((credential) {
                    Navigator.pushNamed(context, '/home');
                  });
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Consumer<AuthenticationController>(
                  builder: (context, controller, _) {
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
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
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
    );
  }
}
