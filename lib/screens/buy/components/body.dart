//===========================================================================//
//============================Cuerpo de vista buy ===========================//
//===========================================================================//

import 'dart:async';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/buy/components/header.dart';
import 'package:experiencias_magicas/screens/buy/components/paquetes.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//variables para almacenar los valores desde la API
  List<Paquetes> widgetPaquetes = [];

//Carga de datos
  @override
  void initState() {
    super.initState();
    //Reload cada dos minutos
    cargarTablas();
  }

  Future<void> cargarTablas() async {
    widgetPaquetes = [];

    parametros = {"opcion": "3.2"};

    var respuesta = await peticiones(parametros);

    if (respuesta != "err_internet_conex") {
      setState(() {
        if (respuesta == 'empty') {
          widgetPaquetes = [];
          // isLoading = false;
        } else {
          for (int i = 0; i < respuesta.length; i++) {
            widgetPaquetes.add(
              Paquetes(dias: respuesta[i]['days'], plus: respuesta[i]['plus'], 
              costo: respuesta[i]['cost'], titulo: respuesta[i]['id_package'])
            );
          }
          // isLoading = false;
        }
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // const HomeHeader(),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  Text(
                    "¡Bla bla bla bla bla bla blasdasdasdasa bla!",
                    style: headingStyleTwo,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  DividerLine(150),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  BuyHeader(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DividerLine(150),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  Text(
                    "¡Bla bla bla!",
                    style: headingStyleTwo,
                    textAlign: TextAlign.center,
                  ),

                  // const Paquetes(),
                  Column(
                    children: widgetPaquetes,
                  ),

                  SizedBox(height: getProportionateScreenHeight(10)),
                  // const Column(
                  //   children: [DayScreen()],
                  // ),

                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
            onRefresh: () async {}));
  }

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
