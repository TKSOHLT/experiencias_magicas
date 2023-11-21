
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class CardNotificacion extends StatefulWidget {
  const CardNotificacion({
    Key? key,
    required this.text,
    required this.datetime,
    required this.icon,
    required this.id,
    this.press,
  }) : super(key: key);

  final String text, datetime, id;
  final Icon icon;
  final VoidCallback? press;

  @override
  _CardNotificacionState createState() =>
      _CardNotificacionState(text, datetime, id, icon, press);
}

class _CardNotificacionState extends State<CardNotificacion> {
  _CardNotificacionState(
      this.text, this.datetime, this.id, this.icon, this.press);
  final String text, datetime, id;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    DateTime fechaActual = DateTime.now();
    // String fecha = fechaActual.toString().substring(0, 10);

    // Parsea las cadenas de hora en objetos DateTime
    final castHora = DateTime.parse("$datetime");

    // Resta los objetos DateTime
    final diferencia = fechaActual.difference(castHora);

    Future<void> cargarNumeroNotificaciones() async {
      parametros = {"opcion": "3.2"};

      var respuesta = await peticiones(parametros);
      if (respuesta != "empty" &&
          respuesta != "error" &&
          respuesta != "err_internet_conex") {
        if (respuesta[0]['total'] is String) {
          lblTotalNotifications = int.parse(respuesta[0]['total']);
        } else {
          lblTotalNotifications = respuesta[0]['total'];
        }
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
    }

    return Dismissible(
        // Muestra un background rojo a medida que el elemento se elimina
        background: Container(
          height: 80,
          // width: getProportionateScreenWidth(10),
          decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
          ),
          padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
                size: getProportionateScreenHeight(30),
              )
            ],
          ),
        ),
        key: Key(id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          // await Future.delayed(Duration(milliseconds: 500)); // Espera un momento (ajusta el tiempo según tus necesidades)

          parametros = {"opcion": "3.1", "id_notification": id};

          var response = await peticiones(parametros);

          if (response == "success") {
            await cargarNumeroNotificaciones();
          } else {
            if (mounted) {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Error de conexión',
                subtitle: 'Verifique su conexión e intentelo de nuevo',
                configuration: const IconConfiguration(icon: Icons.error),
                maxWidth: 260,
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              elevation:
                  4, // Ajusta el valor de la elevación según tus preferencias
              primary: Color.fromARGB(255, 0, 0, 0),
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.white,
              shadowColor: Color.fromARGB(255, 18, 17, 17),
            ),
            onPressed: press,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: getProportionateScreenWidth(250)),
                          child: Text(
                            "$text",
                            // style: lblCompra,
                            // overflow: TextOverflow.fade,
                            // softWrap: false,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        const Icon(Icons.history, color: Colors.amber),
                        if (diferencia.inDays >= 1) ...[
                          Text(
                            "Hace ${diferencia.inDays} dia(s) con ${diferencia.inHours - 24} hora(s)",
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth <= 360
                                    ? getProportionateFontSize(12)
                                    : getProportionateFontSize(16)),
                          )
                        ] else ...[
                          Text(
                              "Hace ${diferencia.inHours} hora(s) con ${diferencia.toString().substring(2, 4)} minuto(s)",
                              style: TextStyle(
                                  fontSize: SizeConfig.screenWidth <= 360
                                      ? getProportionateFontSize(12)
                                      : getProportionateFontSize(16)))
                        ]
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
