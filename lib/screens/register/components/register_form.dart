import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/custom_surfix_icon.dart';
import 'package:experiencias_magicas/components/default_button.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/home/home_screen.dart';
import 'package:experiencias_magicas/screens/superhome/superhome.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String? userName;
String? phone;
String? email;
String? password;
bool hidePass = true;

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  bool loading = false;
  void addError({String? error}) {
    if (!errors.contains(error)) {
      if (mounted) {
        setState(() {
          errors.add(error);
        });
      }
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          // SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(15)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                text: "Cancelar",
                press: () {
                  Navigator.pop(context);
                },
              ),
              DefaultButton(
                text: "Continuar",
                press: () async {
                  if (loading) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: SpinKitChasingDots(
                                color: Colors.white, size: 140),
                          );
                        });
                  }

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SuperHomeScreen(),
                    ),
                    //funcion que limpia la pila de rutas anteriores
                    (route) => false,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      obscureText: hidePass,
      onSaved: (newValue) => userName = newValue!,
      //validar contraseña
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },

      decoration: InputDecoration(
        labelText: "Nombre de usuario",
        hintText: "Ingresa tu nombre",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
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

  TextFormField buildPhoneFormField() {
    return TextFormField(
      obscureText: hidePass,
      onSaved: (newValue) => phone = newValue!,
      //validar contraseña
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },

      decoration: InputDecoration(
        labelText: "Número telefónico",
        hintText: "Ingresa tu número telefónico",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidePass,
      onSaved: (newValue) => password = newValue!,
      //validar contraseña
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
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
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      //Validar email
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
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
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
