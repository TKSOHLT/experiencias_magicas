//===========================================================================//
//============================Cuerpo de vista chat===========================//
//===========================================================================//

import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/chat/components/chat_row.dart';
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
  Future<void> cargarOpiniones() async {
    nuevoItinerario = false;
    widgetOpiniones = [];

    parametros = {"opcion": "3.7"};
    var respuesta = await peticiones(parametros);
    print(respuesta);
    if (respuesta != "err_internet_conex") {
      if (mounted) {
        setState(() {
          if (respuesta == 'empty') {
          } else {
            for (int i = 0; i < respuesta.length; i++) {
              widgetOpiniones.add(ChatRow(
                  text: respuesta[i]['opinion'],
                  name: respuesta[i]['name_user'],
                  stars: respuesta[i]['stars'], 
                  image: respuesta[i]['photo']));
            }
          }
          // isLoading = false; // Indicamos que hemos terminado de cargar
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
  void initState() {
    super.initState();
    //Reload cada dos minutos
    // reload();
    cargarOpiniones();
    print("holiiiii");
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return const Center(
    //     child: SpinKitChasingDots(color: Colors.white, size: 140),
    //   );
    // } else {
    return Column(children: [
      RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                // const HomeHeader(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Column(children: widgetOpiniones),
              ],
            ),
          ),
          onRefresh: () async {})
    ]);
    // }
  }
}
