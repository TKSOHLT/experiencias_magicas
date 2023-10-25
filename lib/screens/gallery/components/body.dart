//==============================================================================//
//============================Cuerpo de vista gallery===========================//
//==============================================================================//

import 'dart:async';
import 'dart:math';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/gallery/components/gallery.dart';
import 'package:experiencias_magicas/screens/gallery/components/gallery_form.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:gridded_pageview/gridded_pageview.dart';
import 'package:experiencias_magicas/global_functions.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController _controller = PageController(keepPage: true);

//Carga de datos de usuario mandadero desde controlador
  @override
  void initState() {
    super.initState();
    //Reload cada dos minutos
    reload();
  }

  void reload() {
    Timer(const Duration(seconds: 120), () {
      reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GriddedPageView(
        controller: _controller,
        minChildWidth: 160,
        minChildHeight: 160,
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    _createOnPressedStateful(context, Gallery());
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .circle, // Configura la forma del contenedor como un círculo
                          border: Border.all(style: BorderStyle.solid),
                        ),
                        child: ClipOval(
                          // Utiliza ClipOval para recortar la imagen en forma de círculo
                          child: Image.asset(
                            "assets/images/splash_3.jpeg",
                            height: getProportionateScreenHeight(100),
                            width: getProportionateScreenWidth(100),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text("Holi")
                    ],
                  ))),

          //Agregar galeria
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    _createOnPressedStateful(context, GalleryForm());
                  },
                  child: Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(minHeight: getProportionateScreenHeight(100), minWidth: getProportionateScreenWidth(100)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape
                              .circle, // Configura la forma del contenedor como un círculo
                          border: Border.all(style: BorderStyle.solid),
                        ),
                        child: ClipOval(
                          // Utiliza ClipOval para recortar la imagen en forma de círculo
                          child: Icon(Icons.add)
                        ),
                      ),
                    ],
                  )))
        ]);
    // overlapIndicator: false,
  }

  _createOnPressedStateful(BuildContext context, StatefulWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }
}
