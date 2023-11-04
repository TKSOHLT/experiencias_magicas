import 'dart:io';

class Actividad {
  File? imagen;
  String? actividad;

  Actividad({required this.imagen, required this.actividad});
}

class Itinerario {
  // File? imagen;
  int? id;
  int? id_actividad;
  Itinerario({required this.id, required this.id_actividad});
}
