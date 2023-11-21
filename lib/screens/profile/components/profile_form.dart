import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/custom_surfix_icon.dart';
import 'package:experiencias_magicas/components/default_button.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/login/login_screen.dart';
import 'package:experiencias_magicas/screens/profile/components/profile_pic.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    Key? key,
    // ignore: non_constant_identifier_names
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  // ignore: non_constant_identifier_names
  final GlobalKey<_ProfileFormState> key = GlobalKey<_ProfileFormState>();

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? phone;
  String? firstName;
  String? lastName;
  String? conform_password;
  String? foto;
  bool isLoading = true;
  bool hidePass = true, hideConfirmPass = true;
  final List<String?> errors = [];

  Future<void> cargarDatos() async {
    print("Cargando datos usuario");
    parametros = {"opcion": "1.1"};

    var respuesta = await peticiones(parametros);

    if (respuesta != "err_internet_conex") {
      if (mounted) {
        setState(() {
          if (respuesta == 'user_not_found') {
            isLoading = false;
          } else {
            foto = email = respuesta["photo"];
            email = respuesta["email"];
            password = respuesta["password"];
            phone = respuesta["phone"];
            firstName = respuesta["first_name"];
            lastName = respuesta["last_name"];
            isLoading = false;
          }
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    cargarDatos();
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
    if (isLoading) {
      return const Center(
        child: SpinKitCubeGrid(color: Colors.white, size: 140),
      );
    } else {
      return Form(
          key: _formKey,
          // child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: getProportionateScreenWidth(10)),
          child: Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(50)),
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
                ProfilePic(
                  foto: foto,
                  callback: () {
                    setState(() {
                      cargarDatos();
                      isLoading = true;
                    });
                  },
                ),
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

                              parametros = {
                                "opcion": "1.2",
                                "email": email,
                                "password": password,
                                "phone": phone,
                                "firstName": firstName,
                                "lastName": lastName
                              };

                              var respuesta = await peticiones(parametros);
                              switch (respuesta) {
                                case "exito":
                                  if (mounted) {
                                    QuickAlertSuccess(context,
                                        "¡Se han modificado los datos correctamente!");

                                    setState(() {
                                      cargarDatos();
                                      isLoading = true;
                                    });
                                  }
                                  break;
                                case "error":
                                  if (mounted) {
                                    Navigator.pop(context);
                                    QuickAlertError(context,
                                        "¡Ha ocurrido un error al hacer la petición!");
                                  }
                                  break;
                              }
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      SizedBox(
                        width: getProportionateScreenHeight(330),
                        height: getProportionateScreenHeight(56),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 232, 62,
                                  54), // Cambia el color del borde según tus preferencias
                              width:
                                  1.0, // Ajusta el ancho del borde según tus preferencias
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 232, 62, 54),
                          ),
                          onPressed: () => cerrarSesion(),
                          child: Text(
                            "Cerrar sesión",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: const Color.fromARGB(255, 240, 240, 240),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ));
    }
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

  dynamic cerrarSesion() {
    return showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text("¿Desea cerrar sesión?",
                style: TextStyle(color: Color.fromARGB(255, 218, 11, 11))),
            content: const Text("La sesión se cerrará"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Color.fromARGB(255, 23, 21, 21)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Cerrar sesión",
                  style: TextStyle(color: Color.fromARGB(255, 218, 11, 11)),
                ),
                onPressed: () async {
                  Route ruta =
                      MaterialPageRoute(builder: (context) => LoginScreen());

                  Navigator.pushAndRemoveUntil(
                      context, ruta, (Route<dynamic> route) => false);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();

                  // setState(() {
                  //   isLoggedIn = false;
                  // });
                },
              )
            ],
          );
        });
  }
}
