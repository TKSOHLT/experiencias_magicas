//===========================================================================//
//============================ Cuerpo de paquetes ===========================//
//===========================================================================//

import 'dart:async';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/buy/components/header.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/screens/models/product.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class Paquetes extends StatefulWidget {
  const Paquetes({
    required this.dias,
    required this.plus,
    required this.costo,
    required this.titulo,
    super.key,
  });

  final int titulo;
  final List<dynamic> dias;
  final List<dynamic> plus;
  final num costo;

  @override
  State<Paquetes> createState() => _PaquetesState();
}

class _PaquetesState extends State<Paquetes> {
//variables para almacenar los valores desde la API
  bool isLoading = true;
  bool visible = true;
  String texto = "";
  int invertIndex = 0;
  final List<String?> errors = [];
 
  //Var lengths
  int lengthDias = 0;
  int lengthPlus = 0;

//Carga de datos de usuario mandadero desde controlador
  @override
  void initState() {
    super.initState();
    //Reload cada dos minutos
  }

  @override
  Widget build(BuildContext context) {

    if( widget.dias.length > 1){
      lengthDias = widget.dias.length;
    }else if(widget.dias.length == 1 && widget.dias[0] == ""){
      lengthDias = 0;
    }else{
     lengthDias = 1;
    }

    if( widget.plus.length > 1){
      lengthPlus = widget.plus.length;
    }else if(widget.plus.length == 1 && widget.plus[0] == ""){
      lengthPlus = 0;
    }else{
     lengthPlus = 1;
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Paquete ${widget.titulo}",
                    style: headingStyleTwo,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = visible ? false : true;
                          });
                        },
                        icon: Icon(
                            !visible ? Icons.expand_more : Icons.expand_less,
                            color: Colors.white)))
              ],
            ),
            Visibility(
                visible: visible,
                child: Column(
                  children: [
                    buildDataTable(),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Column buildDataTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            width: getProportionateScreenWidth(350),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 0),
                      child: Column(children: [
                        SizedBox(
                            width: getProportionateScreenWidth(350),
                            child: DataTable(
                              
                              columns: [
                                DataColumn(label:  Expanded(child: Text('Plus', textAlign: TextAlign.center, style: styleDataHeader))),
                                DataColumn(label: Expanded(child:Text('Contiene', textAlign: TextAlign.center, style: styleDataHeader))),
                              ],
                              rows: List<DataRow>.generate((lengthDias) + (lengthPlus), (index) {

                                  if(index <= (lengthDias - 1)){
                                    texto = "Dia ${widget.dias[index]}";
                                  }else{
                                    try{
                                      texto = widget.plus[invertIndex];
                                      invertIndex++;
                                    }catch(e){
                                      print(e);
                                    }
                                    
                                  }

                                return DataRow(cells: <DataCell>[
                                  DataCell(Center(
                                      // constraints: BoxConstraints(
                                      //     maxWidth:
                                      //         getProportionateScreenWidth(70)),
                                      child: Text(
                                         texto,
                                         style: styleDataRow,
                                      ))),
                                  const DataCell(Center(
                                      // constraints: BoxConstraints(
                                      //     maxWidth:
                                      //         getProportionateScreenWidth(70)),
                                      child: Icon(Icons.sentiment_very_satisfied_outlined, color: kPrimaryColor,))),
                                ]);
                              }),
                              columnSpacing: BorderSide.strokeAlignCenter,
                            )),
                            Text("A solo: \$${widget.costo}", style: styleBuyCosto)
                      ])),
                  btnBuy(),
                ]))
      ],
    );
  }

  InkWell btnBuy() {
    return InkWell(
      onTap: () {
        if(products.isEmpty){
          products.add(Product('assets/images/splash_1.jpeg', "Paquete ${widget.titulo}", "Viajan $cantidadPersonas personas", widget.costo * cantidadPersonas, cantidadPersonas, 1));
        }else{
          products[0].image = 'assets/images/splash_1.jpeg';
          products[0].name = "Paquete ${widget.titulo}";
          products[0].description = "Viajan $cantidadPersonas personas";
          products[0].price = widget.costo * cantidadPersonas;
          products[0].places = cantidadPersonas;
          products[0].id_paquete = 1;
        }
        QuickAlertSuccess(context, "¡Se ha agregado al carrito!");
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 74, 179, 156),
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0)),
        ),
        child: Text(
          "¡Agregar al carrito!",
          style: styleBtnBuy,
          textAlign: TextAlign.center,
        ),
      ),
    );
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
