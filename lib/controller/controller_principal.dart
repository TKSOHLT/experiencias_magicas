import '../../request/api_request.dart';

Future<dynamic> peticiones(Map<String, dynamic> parametros) async {

  var response;

  switch (parametros['opcion']) {
    case '1':
      response = iniciarSesion();
      return response;
    case '2':
      response = agregarPaquete();
      return response;
    case '3':
      response = cargarFechas();
      return response;
    case '3.1':
      response = cargarLugaresDisponibles();
      return response;
    case '3.2':
      response = cargarPaquetes();
      return response;

    default:
      return "opcion_no_valida";
  }
}