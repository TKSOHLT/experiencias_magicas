//Esta función vuelve a crear la ruta una vez se desheche
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _createOnPressed(BuildContext context, StatelessWidget route) async {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  await Navigator.push(context, materialRoute);
  // return true;
}

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return bool
    String? id = prefs.getString('id_usuario');
    return id;
  }

  getUserRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return bool
    String? rol = prefs.getString('rol');
    return rol;
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return bool
    String? token = prefs.getString('nombre_usuario');
    return token;
  }

  getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Return bool
    String? token = prefs.getString('telefono');
    return token;
  }

void QuickAlertSuccess(BuildContext context, String message){
  QuickAlert.show(
  context: context,
  type: QuickAlertType.success,
  text: message,
  );
}

void QuickAlertError(BuildContext context, String message){
  QuickAlert.show(
  context: context,
  type: QuickAlertType.error,
  text: message,
  );
}

void QuickAlertWarning(BuildContext context, String message){
  QuickAlert.show(
    context: context, 
    type: QuickAlertType.warning,
    text: message
    );
}

void showNotification(BuildContext context, String title, String message,
  
  String opcion, RemoteMessage remoteMess) {
  VoidCallback? press;

  DateTime fechaActual = DateTime.now();
  String fecha = fechaActual.toString().substring(0, 10);

  switch (opcion) {
    //Compra agregada (mandadero)
    case "1":
      break;
    //Compra finalizada (admin)
    case "2":
      break;
    //Compra cancelada (mandadero)
    case "3":
      break;
  }

  InAppNotifications.show(
      title: title,
      leading: const Icon(
        Icons.fact_check,
        color: Colors.green,
        size: 50,
      ),
      ending: const Icon(
        Icons.arrow_right_alt,
        color: Colors.red,
      ),
      description: message,
      onTap: press);
}
