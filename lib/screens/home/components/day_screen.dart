import 'package:experiencias_magicas/components/coustom_nav_bar.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/enum.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/models.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/screens/home/components/card_activity.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

//Activar edición
List<Actividad> newActividades = [];

class DayScreen extends StatefulWidget {
  DayScreen(
      {super.key,
      required this.id_itinerario,
      required this.dia,
      required this.actividades,
      required this.fotos,
      required this.onEdit,
      required this.callback});
  final id_itinerario;
  final actividades;
  final fotos;
  final dia;
  final callback;
  late bool onEdit;

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  List<Widget> widgetCardActivity = [];
  List actividades = [];
  List fotos = [];
  int cantidadActividadesServidor = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    cargarActividades();
  }

  Future<void> cargarActividades() async {
    widgetCardActivity = [];
    fotos = [];

    if (widget.actividades != "") {
      actividades = widget.actividades.split(",");
      fotos = widget.fotos.split(",");

      setState(() {
        cantidadActividadesServidor = actividades.length - 1;

        for (int i = 0; i < actividades.length; i++) {
          widgetCardActivity.add(
            CardActivity(
              cantidadActividadesServidor: cantidadActividadesServidor,
              photo: fotos[i],
              text: actividades[i],
              id: widgetCardActivity.length,
            ),
          );
        }
      });
    } else {
      setState(() {
        editItinerary = true;
      });
      // widgetCardActivity.add(
      //   CardActivity(
      //     text: "Cuevas",
      //     id: 0,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(
        children: [
          Text(
            "Dia ${widget.dia}",
            style: styleTitleHome,
          ),
          Form(
            key: _formKey,
            child: GestureDetector(
                onLongPress: () {
                  if (rol == "1") {
                    setState(() {
                      editItinerary = true;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          Color.fromARGB(255, 240, 240, 240), // Color del borde
                      width: 2.0, // Ancho del borde
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    children: widgetCardActivity,
                  ),
                )),
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
      onTap: () async {
        print("Le pico al boton aceptar");

        // if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // cargarCompras();
        if (!nuevoItinerario) {
          if (newActividades.isNotEmpty) {
            parametros = {
              "opcion": "3.4",
              "id_itinerario": widget.id_itinerario,
              "actividades": newActividades
            };
            var response = await peticiones(parametros);
            switch (response) {
              case "exito":
                if (mounted) {
                  QuickAlertSuccess(
                      context, "¡Se ha modificado la información con éxito!");

                  widget.callback();
                }
                break;
              case "error":
                if (mounted) {
                  Navigator.pop(context);
                  QuickAlertError(
                      context, "¡Ha ocurrido un error al hacer la petición!");
                }
                break;
            }
          }
        } else {
          if (newActividades.isNotEmpty) {
            parametros = {
              "opcion": "3.5",
              "dia": widget.dia,
              "actividades": newActividades
            };

            var response = await peticiones(parametros);

            switch (response) {
              case "exito":
                if (mounted) {
                  QuickAlertSuccess(
                      context, "¡Se ha modificado la información con éxito!");

                  widget.callback();
                }
                break;
              case "error":
                if (mounted) {
                  Navigator.pop(context);
                  QuickAlertError(
                      context, "¡Ha ocurrido un error al hacer la petición!");
                }
                break;
            }
          }
        }
        // }

        setState(() {
          newActividades = [];
          editItinerary = false;
        });
      },
      child: Container(
        constraints: BoxConstraints(minWidth: getProportionateScreenWidth(350)),
        padding: const EdgeInsets.all(10),
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
        if (widgetCardActivity.length > cantidadActividadesServidor) ...[
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

                // nuevoItinerario.removeAt(nuevoItinerario.length - 1);
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
              color: Color.fromARGB(255, 233, 229, 35),
              size: 35.0,
            ),
            highlightColor: const Color.fromARGB(255, 254, 254, 254),
            onPressed: () {
              setState(() {
                // iterador++;
                // products.add(Productos(name: "", cantidad: "", unidad: ""));
                widgetCardActivity.add(
                  CardActivity(
                    cantidadActividadesServidor: cantidadActividadesServidor,
                    photo: '',
                    text: '',
                    id: widgetCardActivity.length - 1,
                  ),
                );

                // nuevoItinerario.add(Itinerario(
                //     id: indexDays, id_actividad: indexItinerary));
                newActividades.add(Actividad(id_foto: null, actividad: ""));

                // indexItinerary++;
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
