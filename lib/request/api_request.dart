import 'dart:convert';

import 'package:experiencias_magicas/globals.dart';
import 'package:http/http.dart' as http;

final url = Uri.parse(
    'http://192.168.16.180:8080/APIExpMagicas/controlador/controlador.php');

// final url = Uri.parse(
//     'http://192.168.0.31:8080/PanelBitalaHidalgo/controller/ControllerBitala1.php');

Future<dynamic> iniciarSesion() async {
  var data = {
    'opcion': '1',
    'correo': parametros["correo"],
    'contrasena': parametros["contrasena"],
  };

  try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  } catch (e) {
    return "err_internet_conex";
  }
}

//Paquetes
Future<dynamic> agregarPaquete() async {

  // if()
  String dias =
      parametros["dias"].join(",");

  String actividades =
      parametros["actividades"].join(",");

  var data = {
    'opcion': '2',
    'fechas': parametros["fechas"],
    'costo': parametros["costo"],
    'lugares': parametros["lugares"],
    'dias': dias,
    'actividades': actividades,
  };

  print("data;;;;;;$data");
  try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  } catch (e) {
    print("Error $e");
    return "err_internet_conex";
  }
}


//Vista comprar
Future<dynamic> cargarFechas() async {

  var data = {
    'opcion': '3'
  };

  try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    }
  } catch (e) {
    return "err_internet_conex";
  }
}

Future<dynamic> cargarLugaresDisponibles() async {
  DateTime fechaActual = DateTime.now();
  String fecha = fechaActual.toString().substring(0, 10);

  var data = {
    'opcion': '3.1',
    'fecha': fecha
  };

  try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    }
  } catch (e) {
    return "err_internet_conex";
  }
}

Future<dynamic> cargarPaquetes() async {
  DateTime fechaActual = DateTime.now();
  String fecha = fechaActual.toString().substring(0, 10);

  var data = {
    'opcion': '3.2',
    'fecha': fecha
  };

  try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
          print("Las pinches fechas feas son:::::: ${response.body}");

      return jsonResponse;
    }
  } catch (e) {
    return "err_internet_conex";
  }
}
