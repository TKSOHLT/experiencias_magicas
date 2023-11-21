//===========================================================================//
//============================Cuerpo de vista home===========================//
//===========================================================================//

import 'dart:async';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/home/components/card_activity.dart';
import 'package:experiencias_magicas/screens/home/components/day_screen.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

int indexDays = 0;
bool editItinerary = false;
bool editDay = false;

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//variables para almacenar los valores desde la API
  String lblTitle = "";
  String? producto;
  String? estado;
  String? idCompra;
  bool isLoading = true;
  int selectedWidgetIndex = -1; // Inicialmente, no hay widget seleccionado

  //Opiniones
  String opinion = "";
  int estrellas = 0;

  final List<String?> errors = [];

//Carga de datos de usuario mandadero desde controlador
  @override
  void initState() {
    super.initState();
    //Reload cada dos minutos
    // reload();
    cargarItinerarios();
  }

  void reload() {
    Timer(const Duration(seconds: 120), () {
      reload();
    });
  }

  Future<void> cargarItinerarios() async {
    nuevoItinerario = false;
    widgetDays = [];

    parametros = {"opcion": "3.3"};
    var respuesta = await peticiones(parametros);

    if (respuesta != "err_internet_conex") {
      if (mounted) {
        setState(() {
          if (respuesta == 'empty') {
          } else {
            for (int i = 0; i < respuesta.length; i++) {
              widgetDays.add(GestureDetector(
                  onLongPress: () async {
                    if (rol == "1") {
                      int opcion = await _showCitiesDialog();

                      switch (opcion) {
                        case 1:
                          setState(() {
                            nuevoItinerario = true;
                            var newIdItinerario = widgetDays.length + 1;
                            widgetDays.add(DayScreen(
                              id_itinerario: newIdItinerario,
                              actividades: "",
                              fotos: "",
                              onEdit: true,
                              dia: widgetDays.length + 1,
                              callback: () {
                                if (mounted) {
                                  setState(() {
                                    cargarItinerarios();
                                    isLoading = true;
                                  });
                                }
                              },
                            ));
                          });
                          break;

                        case 2:
                          parametros = {
                            "opcion": "3.9",
                            "id_itinerario": respuesta[i]['id']
                          };

                          var response = await peticiones(parametros);
                          print("Si jalo :D $response");

                          break;
                      }
                    }
                    // bool completado = await _showCitiesDialog();

                    // if (completado) {
                    //   setState(() {
                    //     parametros = {
                    //       "opcion": "3.6",
                    //       "opinion": opinion,
                    //       "estrellas": estrellas.toString()
                    //     };
                    //   });

                    //   var respuesta = peticiones(parametros);
                    //   print("Si jalo :D $respuesta");

                    //   if (respuesta == "exito") {}
                    // }
                  },
                  child: DayScreen(
                    id_itinerario: respuesta[i]['id'],
                    actividades: respuesta[i]['actividades'],
                    fotos: respuesta[i]['fotos'],
                    onEdit: false,
                    dia: respuesta[i]['dia'],
                    callback: () {
                      if (mounted) {
                        setState(() {
                          cargarItinerarios();
                          isLoading = true;
                        });
                      }
                    },
                  )));
            }
          }
          isLoading = false; // Indicamos que hemos terminado de cargar
        });
      }
    } else {
      if (mounted) {}
    }
    // } catch (e) {
    //   //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HomeHeader(),
                  Text(
                    "¡Bla bla bla bla bla bla blasdasdasdasa bla!",
                    style: headingStyleTwo,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  DividerLine(150),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Text(
                    "¡Bla bla bla bla bla bla blasdasdasdasa bla!",
                    style: headingStyleTwo,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DividerLine(150),

                  SizedBox(height: getProportionateScreenHeight(10)),

                  Column(
                    children: widgetDays,
                  ),

                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
            onRefresh: () async {}));
  }

  Future<int> _showCitiesDialog() {
    final completer = Completer<int>();
    int opcion = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: const Text('Opciones', textAlign: TextAlign.center),
              content: Container(
                width: 400.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          InkWell(
                            onTap: () {
                              opcion = 1;
                              completer.complete(1);
                              Navigator.pop(context);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: getProportionateScreenWidth(300)),
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              decoration: const BoxDecoration(
                                color:
                                    kPrimaryColor, // Cambia kPrimaryColor al color deseado
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Text(
                                "Agregar dias",
                                style: TextStyle(
                                  color: Colors.white, // Color del texto
                                  fontSize: 16, // Tamaño de la fuente
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //button
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: getProportionateScreenHeight(10),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          InkWell(
                            onTap: () {
                              opcion = 2;
                              completer.complete(2);
                              Navigator.pop(context);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: getProportionateScreenWidth(300)),
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 215, 74,
                                    64), // Cambia kPrimaryColor al color deseado
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Text(
                                "Eliminar dia",
                                style: TextStyle(
                                  color: Colors.white, // Color del texto
                                  fontSize: 16, // Tamaño de la fuente
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //button
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    return completer.future;
  }

  // Future<bool> _showCitiesDialog() {
  //   final completer = Completer<bool>();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //             contentPadding: EdgeInsets.only(top: 10.0),
  //             title: const Text('¿Como estuvo tu viaje?',
  //                 textAlign: TextAlign.center),
  //             content: Container(
  //               width: 400.0,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 10.0, right: 10),
  //                     child: Column(
  //                       children: [
  //                         SizedBox(
  //                           height: getProportionateScreenHeight(15),
  //                         ),
  //                         Container(
  //                           constraints: BoxConstraints(
  //                               minWidth: getProportionateScreenWidth(300)),
  //                           padding:
  //                               const EdgeInsets.only(top: 20.0, bottom: 20.0),
  //                           decoration: const BoxDecoration(
  //                             color: Color.fromARGB(109, 119, 192,
  //                                 103), // Cambia kPrimaryColor al color deseado
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(10)),
  //                           ),
  //                           child: TextField(
  //                             onChanged: (value) => setState(() {
  //                               opinion = value;
  //                             }),
  //                             decoration: const InputDecoration(
  //                                 focusColor: Colors.white,
  //                                 fillColor: Colors.white,
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide:
  //                                       BorderSide(color: Colors.transparent),
  //                                 ),
  //                                 enabledBorder: OutlineInputBorder(
  //                                   borderSide:
  //                                       BorderSide(color: Colors.transparent),
  //                                 ),
  //                                 contentPadding: EdgeInsets.only(
  //                                     bottom: 5, top: 0, left: 10, right: 10),
  //                                 isDense: true,
  //                                 floatingLabelBehavior:
  //                                     FloatingLabelBehavior.never,
  //                                 alignLabelWithHint: true,
  //                                 border: InputBorder.none),
  //                             keyboardType: TextInputType.number,
  //                           ),
  //                         ),
  //                         //button
  //                         SizedBox(
  //                           height: getProportionateScreenHeight(30),
  //                         ),
  //                       ],
  //                     ),
  //                   ),

  //                   //Estrellas
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       IconButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               if (estrellas == 1) {
  //                                 estrellas = 0;
  //                               } else {
  //                                 estrellas = 1;
  //                               }
  //                               // estrellas == 1 ? estrellas = 1 : estrellas = 0;
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.star,
  //                             color: estrellas >= 1
  //                                 ? Colors.amber
  //                                 : Color.fromARGB(255, 37, 36, 36),
  //                             size: 45,
  //                           )),
  //                       IconButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               print("jala=?");
  //                               estrellas = 2;
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.star,
  //                             color: estrellas >= 2
  //                                 ? Colors.amber
  //                                 : Color.fromARGB(255, 37, 36, 36),
  //                             size: 45,
  //                           )),
  //                       IconButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               estrellas = 3;
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.star,
  //                             color: estrellas >= 3
  //                                 ? Colors.amber
  //                                 : Color.fromARGB(255, 37, 36, 36),
  //                             size: 45,
  //                           )),
  //                       IconButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               estrellas = 4;
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.star,
  //                             color: estrellas >= 4
  //                                 ? Colors.amber
  //                                 : Color.fromARGB(255, 37, 36, 36),
  //                             size: 45,
  //                           )),
  //                       IconButton(
  //                           onPressed: () {
  //                             setState(() {
  //                               estrellas = 5;
  //                             });
  //                           },
  //                           icon: Icon(
  //                             Icons.star,
  //                             color: estrellas >= 5
  //                                 ? Colors.amber
  //                                 : Color.fromARGB(255, 37, 36, 36),
  //                             size: 45,
  //                           )),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: getProportionateScreenHeight(30),
  //                   ),

  //                   InkWell(
  //                     onTap: () {
  //                       completer.complete(true);

  //                       Navigator.pop(context);
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
  //                       decoration: const BoxDecoration(
  //                         // color: Color.fromARGB(255, 74, 179, 156),
  //                         color: Color.fromARGB(255, 119, 192, 103),
  //                         borderRadius: BorderRadius.only(
  //                             bottomLeft: Radius.circular(32.0),
  //                             bottomRight: Radius.circular(32.0)),
  //                       ),
  //                       child: const Text(
  //                         "Enviar",
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  //   return completer.future;
  // }

  Row DividerLine(double ancho) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: ancho, // Ancho personalizado para la línea
          height: 2, // Grosor de la línea
          color: Color.fromARGB(255, 253, 253, 253), // Color de la línea
        ),
        Container(
          width: 10, // Ancho personalizado para el círculo
          height: 10, // Altura personalizada para el círculo
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Establece la forma como círculo
            color: Color.fromARGB(255, 255, 255, 255), // Color del círculo
          ),
        ),
        Container(
          width: ancho, // Ancho personalizado para la línea
          height: 2, // Grosor de la línea
          color: Color.fromARGB(255, 255, 255, 255), // Color de la línea
        ),
      ],
    );
  }
}
