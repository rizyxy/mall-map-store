import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mallmap_store/controller/authentication_controller.dart';
import 'package:mallmap_store/controller/product_controller.dart';
import 'package:mallmap_store/firebase_options.dart';
import 'package:mallmap_store/views/auth/forgot_page.dart';
import 'package:mallmap_store/views/auth/login_page.dart';
import 'package:mallmap_store/views/auth/profile_page.dart';
import 'package:mallmap_store/views/auth/register_page.dart';
import 'package:mallmap_store/views/main/create_product_page.dart';
import 'package:mallmap_store/views/main/edit_product_page.dart';
import 'package:mallmap_store/views/main/home_page.dart';
import 'package:mallmap_store/views/onboarding_page.dart';
import 'package:mallmap_store/views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MallMap());
}

class MallMap extends StatelessWidget {
  const MallMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => AuthenticationController())
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/forgot': (context) => ForgotPage(),
          '/profile': (context) => const ProfilePage(),
          '/home': (context) => const HomePage(),
          '/create-product': (context) => CreateItemPage(),
          '/edit-product': (context) => EditItemPage()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
      ),
    );
  }
}
