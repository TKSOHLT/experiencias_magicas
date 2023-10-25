import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/profile/components/profile_form.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: SizeConfig.screenHeight,
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text("Editar datos", style: headingStyleTwo),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    Text(
                      "Edite sus datos con precauciòn.",
                      // style: lblAddUser,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.07),
                    ProfileForm(),
                    //SizedBox(height: SizeConfig.screenHeight * 0.08),
                    /*Text(
                    '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  )*/
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
