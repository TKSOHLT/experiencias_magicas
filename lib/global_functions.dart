//Esta función vuelve a crear la ruta una vez se desheche
import 'package:flutter/material.dart';

void _createOnPressed(BuildContext context, StatelessWidget route) async {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  await Navigator.push(context, materialRoute);
  // return true;
}

  // Future<dynamic> showEliminarImagen(int index) {
  //   return showDialog(
  //       context: context,
  //       builder: (buildcontext) {
  //         return AlertDialog(
  //           title: const Text("¿Deséa eliminar ésta imagen?",
  //               style: TextStyle(color: Color.fromARGB(255, 218, 11, 11))),
  //           //content: const Text("La sesión se cerrará"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text(
  //                 "No",
  //                 style: TextStyle(color: Color.fromARGB(255, 23, 21, 21)),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             TextButton(
  //               child: const Text(
  //                 "Si, eliminar",
  //                 style: TextStyle(color: Color.fromARGB(255, 218, 11, 11)),
  //               ),
  //               onPressed: () async {
  //                 await imagesPath.removeAt(index);
  //                 await files.removeAt(index);

  //                 Navigator.of(context).pop();

  //                 setState(() {
  //                   recargarImagenes = true;
  //                 });

  //                 // setState(() {
  //                 //   isLoggedIn = false;
  //                 // });
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }