import 'package:experiencias_magicas/models.dart';
import 'package:experiencias_magicas/screens/chat/components/chat_row.dart';
import 'package:experiencias_magicas/screens/home/components/day_screen.dart';
import 'package:experiencias_magicas/screens/models/product.dart';
import 'package:flutter/material.dart';

int lblTotalNotifications = 0;
List<Widget> widgetNofiticaciones = [];

Map<String, dynamic> parametros = {};

List<Widget> widgetDays = [];

// List<Itinerario> nuevoItinerario = [];

bool nuevoItinerario = false;

List<ChatRow> widgetOpiniones = [];

List<Product> products = [];

List<String> imagenesServidor = [];

String urlImages = "http://192.168.0.18:8080/APIExpMagicas/imagenes/";

String rol = "";