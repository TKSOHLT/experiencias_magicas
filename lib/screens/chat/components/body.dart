//===========================================================================//
//============================Cuerpo de vista chat===========================//
//===========================================================================//

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

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
//Carga de datos de usuario mandadero desde controlador
  @override
  Widget build(BuildContext context) {
    //Manejo de las notificaciones firebase

    // if (isLoading) {
    //   return const Center(
    //     child: SpinKitChasingDots(color: Colors.white, size: 140),
    //   );
    // } else {
    return SafeArea(
        child: RefreshIndicator(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // const HomeHeader(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Column(
                    children: [ChatRow(text: "text", status: "status", name: "name", hour: "hour", icon: "icon", allText: "allText")]
                  ),
                ],
              ),
            ),
            onRefresh: () async {}));
    // }
  }
}
