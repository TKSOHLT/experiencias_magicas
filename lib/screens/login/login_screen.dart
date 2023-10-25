import 'package:flutter/material.dart';
import 'components/login_body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash_3.jpeg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          body: Body(),
        ),
      ],
    );
  }
}
