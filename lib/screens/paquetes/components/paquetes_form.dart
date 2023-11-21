import 'dart:io';

import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/datepicker.dart';
import 'package:experiencias_magicas/components/form_error.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/paquetes/components/dias.dart';
import 'package:experiencias_magicas/screens/paquetes/components/plus.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

//variable global para modificar datos de plus de paquete
List<String>? plus = [];
List<String>? dias = [];

class PaquetesForm extends StatefulWidget {
  const PaquetesForm({super.key});
  //Parametros que se comparten desde la vista anterior
  @override
  _PaquetesFormState createState() => _PaquetesFormState();
}

class _PaquetesFormState extends State<PaquetesForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String?> errors = [];

  //====================Controladores de texto====================//
  TextEditingController fechasController = TextEditingController();
  TextEditingController costoController = TextEditingController();
  TextEditingController luagresController = TextEditingController();
  TextEditingController diasController = TextEditingController();

  //Variables para almacenar los valores
  String? fechas;
  String? costo;
  String? lugares;

  //WidgetList plus
  List<Widget> widgetPlus = [];
  //Widget dias
  List<Widget> widgetDias = [];

  Future<void> cargarDias() async {
    widgetDias = [];

    parametros = {"opcion": "3.8"};

    var respuesta = await peticiones(parametros);
    print(respuesta);

    if (respuesta != "err_internet_conex") {
      setState(() {
        if (respuesta == 'empty') {
          widgetDias = [];
          // isLoading = false;
        } else {
          for (int i = 0; i < respuesta.length; i++) {
            widgetDias.add(
              Dias(
                noDia: respuesta[i]['day'].toString(),
              ),
            );
          }
          // isLoading = false;
        }
      });
    } else {}
  }

  //listener para escuchar el cambio en los campos de entrada de montos
  @override
  void initState() {
    super.initState();

    cargarDias();
    widgetPlus.add(Plus());
  }

  //==================================Funciones de Ruta en vistas======================================
  //Esta función vuelve a crear la ruta una vez se desheche
  void _createOnPressed(BuildContext context, StatelessWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }

  void _createOnPressedStateful(BuildContext context, StatefulWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }

  //==================================================================================================
  @override
  void dispose() {
    // Limpia los controladores al finalizar
    costoController.dispose();
    fechasController.dispose();
    luagresController.dispose();
    diasController.dispose();

    super.dispose();
  }

//==========================================Maneko de errores==========================================
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
  //==================================================================================================

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            //altura proporcional a la pantalla
            height: getProportionateScreenHeight(600),
            //anchura del form proporcional a la pantalla
            width: getProportionateScreenWidth(400),
            //padding: da espaciado interno porporcional a la pantalla
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(0)),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 246, 246),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 70,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  folioCompra(),
                  fechaInicio(),
                  costoPaquete(),
                  asientosPaquete(),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text("Contiene", style: styleEventLblHeader),
                  Column(
                    children: widgetDias,
                  ),
                  Column(
                    children: widgetPlus,
                  ),
                  DividerLine(190, true),
                  SizedBox(height: getProportionateScreenHeight(14)),
                  FormError(errors: errors),
                ],
              ),
            ),
          ),
          button(context),
        ],
      ),
    );
  }

//=================================================FUNCIONES DE VISTA=================================================
  Padding button(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            CustomButton(
                text: "Generar",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // plusFormKey.currentState!.save();

                    //============== Función para mostrar dialogo loader ==============//
                    // var loader = true;
                    // if (loader) {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return const Center(
                    //           child: SpinKitChasingDots(
                    //             color: Colors.white,
                    //             size: 140,
                    //           ),
                    //         );
                    //       });
                    // }

                    //============== Petición para obtener el token del usuario mandadero (notificacion) ==============//
                    setState(() {
                      // loader = false;
                    });

                    //============== Petición para subir la compra al servidor ==============//
                    parametros = {
                      "opcion": "2",
                      "fechas": fechas,
                      "dias": dias,
                      "lugares": lugares,
                      "actividades": plus,
                      "costo": costo
                    };

                    var response = await peticiones(parametros);

                    switch (response) {
                      case "exito":
                        if (mounted) {
                          Navigator.pop(context);
                          QuickAlertSuccess(
                              context, "¡Se ha generado el evento!");
                        }
                        break;
                      case "error":
                        if (mounted) {
                          QuickAlertError(context,
                              "¡Ha ocurrido un error al hacer la petición!");
                        }
                        break;
                      default:
                        if (mounted) {
                          QuickAlertWarning(context,
                              "¡Verifique su conexión a internet!");
                        }
                        break;
                    }
                  }
                })
          ]),
        ],
      ),
    );
  }

  Padding fechaInicio() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Fechas: ",
                style: styleEventLblForm,
              ),
            ],
          ),
          SizedBox(
              height: getProportionateScreenHeight(35),
              width: getProportionateScreenWidth(190),
              child: DatePicker(
                onDateChanged: (String newValue) {
                  setState(() {
                    fechas = newValue;
                  });
                },
              ))
        ],
      ),
    );
  }

  Padding folioCompra() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Fólio: ",
                style: styleEventLblForm,
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(100),
            child: TextFormField(
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                  hintText: "1",
                  focusColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  labelStyle: const TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold)
                  /*border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),*/
                  ),
              enabled: false,
              //onSaved: (newValue) => lugar = newValue!,
            ),
          )
        ],
      ),
    );
  }

  Padding costoPaquete() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Costo del paquete: ",
                style: styleEventLblForm,
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              controller: costoController,
              decoration: InputDecoration(
                hintText: "Costo",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return kMontoNullError;
                } else if (!montoValidatorRegExp.hasMatch(newValue)) {
                  return null;
                }
                return null;
              },
              onSaved: (newValue) {
                costo = newValue;
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp('[0-9.([0-9)?]')), // Limita a dígitos solamente
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding asientosPaquete() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Lugares disponibles: ", style: styleEventLblForm),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              controller: luagresController,
              decoration: InputDecoration(
                hintText: "Luagres",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return kMontoNullError;
                }
                return null;
              },
              onSaved: (newValue) {
                lugares = newValue;
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp('[0-9]')), // Limita a dígitos solamente
              ],
            ),
          )
        ],
      ),
    );
  }

  Row DividerLine(double ancho, bool? icon) {
    if (widgetPlus.length < 2) {
      ancho += 50;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Divider(
          height: 50,
        ),
        if (widgetPlus.length >= 2) ...[
          IconButton(
            icon: const Icon(
              Icons.do_disturb_on_rounded,
              color: Color.fromARGB(255, 147, 12, 12),
              size: 35.0,
            ),
            highlightColor: const Color.fromARGB(255, 254, 254, 254),
            onPressed: () {
              setState(() {
                // iterador--;
                // products.removeAt(products.length - 1);
                widgetPlus.removeAt(widgetPlus.length - 1);
              });
            },
          ),
        ],
        Container(
          width: ancho, // Ancho personalizado para la línea
          height: 1, // Grosor de la línea
          color: const Color.fromARGB(255, 174, 173, 173), // Color de la línea
        ),
        if (icon == true) ...[
          IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 81, 181, 15),
              size: 35.0,
            ),
            highlightColor: const Color.fromARGB(255, 254, 254, 254),
            onPressed: () {
              setState(() {
                // iterador++;
                // products.add(Productos(name: "", cantidad: "", unidad: ""));
                widgetPlus.add(Plus());
              });
            },
          ),
        ],
      ],
    );
  }
}
