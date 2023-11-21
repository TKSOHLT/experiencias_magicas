import '../../request/api_request.dart';

Future<dynamic> peticiones(Map<String, dynamic> parametros) async {

  var response;

  switch (parametros['opcion']) {
    case '1':
      response = iniciarSesion();
      return response;
    case '1.1':
      response = obtenerDatosUsuarioPorId();
      return response;
    case '1.2':
      response = actualizarDatosUsuario();
      return response;
    case '1.3':
      response = registrarUsuarioComprador();
      return response;
    case '1.4':
      response = actualizarImagenUsuario();
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
    case '3.3':
      response = cargarItinerario();
      return response;
    case '3.4':
      response = agregarActividades();
      return response;
    case '3.5':
      response = agregarItinerario();
      return response;
    case '3.6':
      response = agregarOpinion();
      return response;
    case '3.7':
      response = obtenerOpiniones();
      return response;
    case '3.8':
      response = obtenerDiasItinerarios();
      return response;
    case '3.9':
      response = eliminarItinerario();
      return response;

    case '4':
      response = agregarCompra();
      return response;
    case '5.1':
      response = obtenerImagenes();
      return response;
    case '6':
      response = obtenerNotificacionesPorId();
      return response;
    default:
      return "opcion_no_valida";
  }
}