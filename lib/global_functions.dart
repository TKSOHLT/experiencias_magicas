//Esta función vuelve a crear la ruta una vez se desheche
import 'package:flutter/material.dart';

void _createOnPressed(BuildContext context, StatelessWidget route) async {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  await Navigator.push(context, materialRoute);
  // return true;
}
