import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/custom_surfix_icon.dart';
import 'package:experiencias_magicas/components/default_button.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/home/home_screen.dart';
import 'package:experiencias_magicas/screens/superhome/superhome.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? phone;
  String? firstName;
  String? lastName;
  String? conform_password;
  bool isLoading = true;
  bool hidePass = true, hideConfirmPass = true;
  final List<String?> errors = [];

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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildphoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

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
                      "opcion": "1.3",
                      "email": email,
                      "password": password,
                      "phone": phone,
                      "firstName": firstName,
                      "lastName": lastName
                    };

                    var respuesta = await peticiones(parametros);

                    if (respuesta != "error") {
                      print("exito papuuuu");
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        prefs.setString('id_usuario', respuesta.toString());
                        prefs.setString('rol', "2");
                        prefs.setString('nombre_usuario', firstName!);
                        prefs.setString('telefono', phone!);
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
                    } else {
                      print(respuesta);
                    }
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
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

  TextFormField buildphoneFormField() {
    return TextFormField(
      initialValue: phone,

      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => phone = newValue,
      //validar email
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        phone = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Telefono",
        hintText: "Ingresa tu nùmero telefònico",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
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
        hintText: "Ingrese el nombre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
