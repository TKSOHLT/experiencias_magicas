import 'dart:io';

class Actividad {
  String? id_foto;
  String? actividad;
  
  Actividad({required this.id_foto, required this.actividad});
}

class Itinerario {
  // File? imagen;
  int? id;
  int? id_actividad;
  Itinerario({required this.id, required this.id_actividad});
}
