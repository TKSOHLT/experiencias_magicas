
import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/custom_surfix_icon.dart';
import 'package:experiencias_magicas/components/default_button.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/profile/components/profile_pic.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    // ignore: non_constant_identifier_names
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ignore: non_constant_identifier_names

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? conform_password;
  bool isLoading = true;
  bool hidePass = true, hideConfirmPass = true;
  final List<String?> errors = [];

  @override
  void initState() {
    super.initState();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return const Center(
    //     child: SpinKitChasingDots(color: Colors.white, size: 140),
    //   );
    // } else {
      return Form(
          key: _formKey,
          // child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: getProportionateScreenWidth(10)),
          child: Container(
            margin: EdgeInsets.only(top: 12.200 * 0.3),
            //height: 500,
            padding: const EdgeInsets.only(
              top: 0,
              left: 20.0,
              right: 20.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),

            child: Column(
              children: [
                ProfilePic(),
                buildFirstNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildLastNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConformPassFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: <Widget>[
                      CustomButton(
                          text: "Cancelar",
                          press: () {
                            Navigator.pop(context);
                          })
                    ]),
                    Column(
                      children: [
                        DefaultButton(
                          text: "Guardar",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ));
    // }
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      initialValue: password,

      obscureText: hideConfirmPass,
      onSaved: (newValue) => conform_password = newValue,
      //validar contraseña
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirmar contraseña",
        hintText: "Ingresa tu contraseña nuevamente",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (hideConfirmPass) {
                  hideConfirmPass = false;
                } else {
                  hideConfirmPass = true;
                }
              });
            },
            icon: const Icon(Icons.remove_red_eye_rounded)),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      initialValue: password,

      obscureText: hidePass,
      onSaved: (newValue) => password = newValue,
      //Verificar contraseña
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresa tu contraseña",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (hidePass) {
                  hidePass = false;
                } else {
                  hidePass = true;
                }
              });
            },
            icon: const Icon(Icons.remove_red_eye_rounded)),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: email,

      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      //validar email
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        hintText: "Ingresa tu correo electrónico",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: lastName,
      onSaved: (newValue) => lastName = newValue,
      decoration: const InputDecoration(
          labelText: "Apellidos",
          hintText: "Ingrese los apellidos",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
          fillColor: Color.fromARGB(255, 244, 244, 244)),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: firstName,
      onSaved: (newValue) => firstName = newValue,
      //Validar nombre
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        firstName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Nombre",
        // hintText: "Ingrese el nombre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
