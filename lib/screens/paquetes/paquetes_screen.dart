
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/paquetes/components/body.dart';
import 'package:flutter/material.dart';

class PaquetesScreen extends StatelessWidget {
  const PaquetesScreen({super.key, required this.idCompra, required this.montoAut, required this.status, required this.idPersonaAut});
  //variables para recibir datos de la vista anterior
  final String idCompra;
  final String montoAut;
  final String status;
  final String idPersonaAut;

  static String routeName = "/paquetes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
          ),
          child: Body(idCompra: idCompra, montoAut: montoAut, status: status, idPersonaAut: idPersonaAut,)),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
      //floatingActionButton: HomeScreen().buildButtonCircularPlus(context)
    );
  }
}
