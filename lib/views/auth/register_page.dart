import 'package:flutter/material.dart';
import 'package:mallmap_store/controller/authentication_controller.dart';
import 'package:mallmap_store/utils/validator/auth_validator.dart';
import 'package:mallmap_store/views/auth/login_page.dart';
import 'package:mallmap_store/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeLocationController =
      TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MainLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Logo(),
            const SizedBox(
              height: 30,
            ),
            Form(
                key: _formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      "Register Your Store Here",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    NormalTextFormField(
                        hintText: "Store Name",
                        validator: (value) =>
                            AuthenticationValidator.validateName(value),
                        controller: _storeNameController),
                    const SizedBox(
                      height: 15,
                    ),
                    NormalTextFormField(
                        controller: _storeLocationController,
                        validator: (value) =>
                            AuthenticationValidator.validateLocation(value),
                        hintText: "Store Location"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Your store location is on what floor your store is located",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    NormalTextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            AuthenticationValidator.validateEmail(value),
                        hintText: "Email Address"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "It's advised that you should not use a personal email for this",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ObscureTextFormField(
                        validator: (value) =>
                            AuthenticationValidator.validatePassword(value),
                        hintText: "Password",
                        controller: _passwordController),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Your password must be 8 characters long minimum containing lowercase, uppercase, number, and symbols",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (_formState.currentState!.validate()) {
                  Provider.of<AuthenticationController>(context, listen: false)
                      .register(
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
                }
              },
              child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Consumer<AuthenticationController>(
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
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already registered a store?"),
                const SizedBox(
                  width: 2,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Login here",
                    style: TextStyle(color: Colors.red),
                  ),
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
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Image.asset('assets/images/shopping-store.png')),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Store Registered",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Store is added to our database. You may now login to MallMap",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Continue",
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
