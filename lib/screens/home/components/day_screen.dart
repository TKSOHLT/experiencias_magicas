import 'package:experiencias_magicas/components/coustom_nav_bar.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/enum.dart';
import 'package:experiencias_magicas/models.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/screens/home/components/card_activity.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

//Activar edición
bool editItinerary = false;
List<Actividad>  newActividades = [];

class DayScreen extends StatefulWidget {
  const DayScreen({
    super.key,
  });

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  List<Widget> widgetCardActivity = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onLongPress: () {
        setState(() {
          editItinerary = true;
        });
      },
      child: Column(
        children: [
          Text("Dia 1"),
          Column(
            children: widgetCardActivity,
          ),
          // CardActivity(
          //   text: '',
          //   status: '',
          //   name: '',
          //   hour: '',
          //   icon: '',
          // ),
          if (editItinerary) ...[DividerLine(200, true), btnSave()]
        ],
      ),
    ));
  }

  InkWell btnSave() {
    return InkWell(
      onTap: () {
        // cargarCompras();
        setState(() {
          editItinerary = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 74, 179, 156),
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0)),
        ),
        child: const Text(
          "Aceptar",
          // style: lblBtnFiltro,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Row DividerLine(double ancho, bool? icon) {
    if (widgetCardActivity.length < 2) {
      ancho += 50;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Divider(
          height: 50,
        ),
        if (widgetCardActivity.length >= 2) ...[
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
                widgetCardActivity.removeAt(widgetCardActivity.length - 1);
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
                widgetCardActivity.add(
                  CardActivity(
                    text: '', id: 1,
                  ),
                );
              });
            },
          ),
        ],
      ],
    );
  }
}

//Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  Navigator.push(context, materialRoute);
}
