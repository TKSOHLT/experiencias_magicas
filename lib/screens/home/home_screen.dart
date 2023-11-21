import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/screens/paquetes/paquetes_screen.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String routeName = "/home";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          height: getProportionateScreenHeight(1000),
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
          ),
          child: const Body(),
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: getProportionateScreenWidth(70)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //   width: getProportionateScreenWidth(0),
                // ),
                rol == "1" ?
                FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    _createOnPressed(context, PaquetesScreen(idCompra: "", montoAut: "100", status: "status", idPersonaAut: "idPersonaAut"));
                  },
                  label: const Text('Evento'),
                  icon: const Icon(Icons.add),
                ): Container()
                // SizedBox(
                //   width: getProportionateScreenWidth(59),
                // ),
                // FloatingActionButton.extended(
                //   backgroundColor: Colors.white,
                //   foregroundColor: Colors.grey,
                //   onPressed: () {
                //     // Add your onPressed code here!
                //   },
                //   label: const Text('Itinerario'),
                //   icon: const Icon(Icons.add),
                // ),
              ],
            )));
  }
}

//Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  Navigator.push(context, materialRoute);
}
