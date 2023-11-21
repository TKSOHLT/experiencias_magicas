import 'dart:io';

import 'package:dio/dio.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/notifications/components/card_notificacion.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:status_alert/status_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;

  @override
  void initState() {
    cargarNotificaciones();
    super.initState();
  }

  Future<void> cargarNotificaciones() async {
    widgetNofiticaciones = [];

    parametros = {"opcion": "6", "id_usuario": await getUserId()};

    var respuesta = await peticiones(parametros);

    if (respuesta != "err_internet_conex") {
      setState(() {
        if (respuesta == 'empty') {
          widgetNofiticaciones = [];
          isLoading = false;
        } else {
          for (int i = 0; i < respuesta.length; i++) {
            widgetNofiticaciones.insert(
                0, SizedBox(height: getProportionateScreenHeight(10)));
            widgetNofiticaciones.insert(
              0,
              CardNotificacion(
                text: respuesta[i]['message'],
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  size: getProportionateScreenHeight(30),
                ),
                press: () {
                  if (rol == "1") {
                    _abrirWhatsApp(respuesta[i]['phone'], respuesta[i]['message']);
                  } else {
                    _downloadDocument(
                        "https://www.turnerlibros.com/wp-content/uploads/2021/02/ejemplo.pdf");
                  }
                },
                id: respuesta[i]['id_notification'].toString(),
                datetime: respuesta[i]['datetime'],
              ),
            );
          }
          lblTotalNotifications = (widgetNofiticaciones.length / 2).round();
          isLoading = false;
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      StatusAlert.show(
        context,
        duration: const Duration(seconds: 2),
        title: 'Error de conexión',
        subtitle: 'Verifique su conexión e intentelo de nuevo',
        configuration: const IconConfiguration(icon: Icons.error),
        maxWidth: 260,
      );
    }

    // } catch (e) {
    //   //
    // }
  }

  Future<void> _downloadDocument(documentUrl) async {
    if (mounted) {
      QuickAlertWarning(
          context, "Descargando la referencia de pago...");
    }

    Dio dio = Dio();
    try {
      Response<List<int>> response = await dio.get<List<int>>(
        documentUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Save the document to local storage (e.g., in the downloads directory)
      String fileName = documentUrl.split('/').last;
      File file = File('/storage/emulated/0/Download/$fileName');
      await file.writeAsBytes(response.data!);

      if (mounted) {
        QuickAlertSuccess(
            context, "Se ha descargado la referencia de pago en  ${file.path}");
      }
    } catch (e) {
      if (mounted) {
        QuickAlertError(context, "Error, intentelo de nuevo");
      }
    }
  }

  //Esta función vuelve a crear la ruta una vez se desheche
  void _createOnPressed(BuildContext context, StatelessWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SpinKitCubeGrid(color: kPrimaryColor, size: 140),
      );
    } else {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Centra el icono a la izquierda
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                      size: 25.0,
                    ),
                    highlightColor: const Color.fromARGB(255, 254, 254, 254),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  //Espacio entre fecha y texto
                  SizedBox(width: getProportionateScreenHeight(32)),
                  Row(children: [
                    Text("Notificaciones", style: headingStyleFour),
                  ]),
                ],
              ),

              Column(children: widgetNofiticaciones)
              // SizedBox(height: getProportionateScreenHeight(10)),
              // CardNotificacion(
              //   text: "Paquete de vasos de plas...",
              //   icon: Icon(Icons.delivery_dining,size: getProportionateScreenHeight(30),),
              //   press: () {},
              //   fecha: '5 horas 23 minutos',
              //   id: "1"
              // ),
              //             SizedBox(height: getProportionateScreenHeight(10)),
              // CardNotificacion(
              //   text: "Paquete de vasos de plas...",
              //   icon: Icon(Icons.delivery_dining,size: getProportionateScreenHeight(30),),
              //   press: () {},
              //   fecha: '5 horas 23 minutos',
              //   id: "1"
              // ),
            ],
          ),
        ),
      );
    }
  }

  // Función para abrir WhatsApp
  _abrirWhatsApp(String telefono, String mensaje) async {
    // Formatear la URL de WhatsApp
    String url = "https://wa.me/$telefono/?text=${Uri.encodeFull(mensaje)}";

    // Verificar si la URL es válida
    if (await canLaunch(url)) {
      // Abrir WhatsApp
      await launch(url);
    } else {
      // Mostrar un mensaje de error si no se puede abrir WhatsApp
      if (mounted) {
        QuickAlertWarning(context, 'No se puede abrir WhatsApp');
      }
    }
  }
}
