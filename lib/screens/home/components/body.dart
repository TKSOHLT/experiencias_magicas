//===========================================================================//
//============================Cuerpo de vista home===========================//
//===========================================================================//

import 'dart:async';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/home/components/card_activity.dart';
import 'package:experiencias_magicas/screens/home/components/day_screen.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
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
  String lblTitle = "";
  String? producto;
  String? estado;
  String? idCompra;
  bool isLoading = true;
  List<Widget> widgetCardActivity = [];

  final List<String?> errors = [];

//Carga de datos de usuario mandadero desde controlador
  @override
  void initState() {
    super.initState();
    //Reload cada dos minutos
    reload();
  }

  void reload() {
    Timer(const Duration(seconds: 120), () {
      reload();
    });
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
                  const Column(
                    children: [DayScreen()],
                  ),
                  
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
