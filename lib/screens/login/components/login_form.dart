import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/custom_surfix_icon.dart';
import 'package:experiencias_magicas/components/default_button.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/register/register_screen.dart';
import 'package:experiencias_magicas/screens/superhome/superhome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String? email;
String? password;
bool? remember = false;
bool hidePass = true;

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          TextButton(
            onPressed: () {},
            child: const Text(
              "¿Olvidaste tu contraseña?",
              style: TextStyle(color: Color.fromARGB(255, 108, 135, 78)),
            ),
          ),
          // SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: "Continuar",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                    final fcmToken =
                        await FirebaseMessaging.instance.getToken();
print("Token:::::::::$fcmToken");
                    if (fcmToken != null) {
                      // parametros = {
                      //   "opcion": "1.8",
                      //   "id_usuario": usuario[0]['id_usuario'].toString(),
                      //   "token": fcmToken.toString()
                      // };

                      // var response = await peticiones(parametros);
                    }

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

                parametros = {
                  "opcion": "1",
                  "correo": email,
                  "contrasena": password
                };

                var respuesta = await peticiones(parametros);

                switch (respuesta) {
                  case "user_not_found":
                    addError(error: 'Usuario no encontrado.');
                    break;
                  case "error":
                    addError(error: 'Usuario o contraseña incorrecta.');
                    break;
                  default:
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      prefs.setString(
                          'id_usuario', respuesta[0]['id_user'].toString());
                      prefs.setString('rol', respuesta[0]['rol'].toString());
                      prefs.setString('nombre_usuario',
                          respuesta[0]['first_name'].toString());
                      prefs.setString(
                          'telefono', respuesta[0]['phone'].toString());
                      rol = respuesta[0]['rol'].toString();
                    });

                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SuperHomeScreen(),
                      ),
                      //funcion que limpia la pila de rutas anteriores
                      (route) => false,
                    );
                }

                setState(() {
                  loading = false;
                });
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomButton(
            text: "Registrarse",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const RegisterScreen(),
                ),
              );
            },
          ),
        ],
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
