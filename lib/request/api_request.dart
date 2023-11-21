import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:http/http.dart' as http;

final url = Uri.parse(
    'http://192.168.0.18:8080/APIExpMagicas/controlador/controlador.php');

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

Future<dynamic> obtenerDatosUsuarioPorId() async {
  var data = {'opcion': '1.1', 'id_usuario': await getUserId()};

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

Future<dynamic> actualizarDatosUsuario() async {
  var data = {
    'opcion': '1.2',
    'id_usuario': await getUserId(),
    'email': parametros['email'],
    'password': parametros['password'],
    'phone': parametros['phone'],
    'firstName': parametros['firstName'],
    'lastName': parametros['lastName']
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

Future<dynamic> registrarUsuarioComprador() async {
  var data = {
    'opcion': '1.3',
    'email': parametros['email'],
    'password': parametros['password'],
    'phone': parametros['phone'],
    'firstName': parametros['firstName'],
    'lastName': parametros['lastName']
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

Future<dynamic> actualizarImagenUsuario() async {
  var data = {
    'opcion': '1.4',
    'id_usuario': parametros['id_usuario'],
    'id_foto': parametros['id_foto']
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
  String dias = parametros["dias"].join(",");

  String actividades = parametros["actividades"].join(",");

  var data = {
    'opcion': '2',
    'fechas': parametros["fechas"],
    'costo': parametros["costo"],
    'lugares': parametros["lugares"],
    'dias': dias,
    'actividades': actividades,
  };

  // try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    }
  // } catch (e) {
  //   return "err_internet_conex";
  // }
}

//Vista comprar
Future<dynamic> cargarFechas() async {
  var data = {'opcion': '3'};

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

  var data = {'opcion': '3.1', 'fecha': fecha};

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

  var data = {'opcion': '3.2', 'fecha': fecha};

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

Future<dynamic> cargarItinerario() async {
  var data = {
    'opcion': '3.3',
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

Future<dynamic> agregarActividades() async {
  String actividades =
      parametros["actividades"].map((act) => act.actividad).join(",");
  String fotos =
      parametros["actividades"].map((act) => act.id_foto).join(",");

  var data = {
    'opcion': '3.4',
    'id_itinerary': parametros['id_itinerario'].toString(),
    'fotos': fotos,
    'nombre': actividades
  };

  // try {
    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    }
  // } catch (e) {
  //   return "err_internet_conex";
  // }
}

Future<dynamic> agregarItinerario() async {
  String actividades =
      parametros["actividades"].map((act) => act.actividad).join(",");
  String fotos =
      parametros["actividades"].map((act) => act.id_foto).join(",");

  var data = {
    'opcion': '3.5',
    'fotos': fotos,
    'nombre': actividades,
    'dia': parametros['dia'].toString()
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

Future<dynamic> agregarOpinion() async {
  var data = {
    'opcion': '3.6',
    'id_usuario': await getUserId(),
    'usuario': await getUserName(),
    'opinion': parametros['opinion'],
    'estrellas': parametros['estrellas']
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

Future<dynamic> obtenerOpiniones() async {
  var data = {
    'opcion': '3.7',
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

Future<dynamic> obtenerDiasItinerarios() async {
  var data = {
    'opcion': '3.8',
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

Future<dynamic> eliminarItinerario() async {
  var data = {
    'opcion': '3.9',
    'id_itinerario': parametros['id_itinerario'].toString()
  };

  // try {
    final response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    }
  // } catch (e) {
  //   return "err_internet_conex";
  // }
}

Future<dynamic> agregarCompra() async {
  DateTime fechaActual = DateTime.now();
  String fecha = fechaActual.toString().substring(0, 10);

  var data = {
    'opcion': '4',
    'id_paquete': parametros['id_paquete'].toString(),
    'id_usuario': await getUserId(),
    'lugares': parametros['lugares'].toString(),
    'total': parametros['total'].toString(),
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

Future<dynamic> agregarImagenes(File rutaImage) async {
  var request = http.MultipartRequest('POST', url);
  
    // Agrega la imagen al formulario de solicitud
  var stream = http.ByteStream(rutaImage.openRead());
  var length = await rutaImage.length();
  var multipartFile = http.MultipartFile('foto', stream, length, filename: rutaImage.path);

  request.files.add(multipartFile);
  request.fields['opcion'] = '5';
  
  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();

      var responseJson;
      responseJson = jsonDecode(responseData);
      print('responseJson:::: $responseJson');

      return responseJson;

    } else {
      print('no se subio la imagen');
      return "error";
    }
  } catch (e) {
    return "err_internet_conex";
  }
}

Future<dynamic> obtenerImagenes() async {
  var data = {
    'opcion': '5.1',
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

Future<dynamic> obtenerNotificacionesPorId() async {
  var data = {
    'opcion': '6',
    'id_usuario': parametros['id_usuario'].toString()
  };

  // try {
    final response = await http.post(
      url,
      body: data,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    }
  // } catch (e) {
  //   return "err_internet_conex";
  // }
}


