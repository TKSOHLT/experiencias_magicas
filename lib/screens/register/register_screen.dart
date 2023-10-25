import 'package:flutter/material.dart';
import 'components/register_body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/splash_2.jpeg",
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
