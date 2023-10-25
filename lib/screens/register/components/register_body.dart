import 'package:experiencias_magicas/screens/login/components/login_form.dart';
import 'package:experiencias_magicas/screens/register/components/register_form.dart';
import 'package:flutter/material.dart';
import '../../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash_2.jpeg"),
          fit: BoxFit.cover,

        )
      ),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 12.200 * 0.3),
          //height: 500,
          padding: const EdgeInsets.only(
            top: 0,
            left: 20.0,
            right: 20.0,
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 246, 246, 246),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(1)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Registrate",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  const Text(
                    "Inicia sesión con tu correo electrónico y tu contraseña.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  RegisterForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ],
              ),
            ),
          ),
        )
        // )),
      ],
    ));
  }
}
