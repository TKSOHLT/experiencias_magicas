
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/gallery/components/gallery_add.dart';
import 'package:experiencias_magicas/screens/paquetes/components/paquetes_form.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class GalleryForm extends StatefulWidget {
  const GalleryForm({super.key});
  //variables que se reciben de la vista anterior
 

  @override
  _GalleryFormState createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleryForm> {
  _GalleryFormState();

  //Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
        Route materialRoute = MaterialPageRoute(builder: (context) => route);
        Navigator.push(context, materialRoute);
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(gradient: kPrimaryGradientColor),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(34)),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Centra el icono a la izquierda
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 254, 254, 254),
                      size: 25.0,
                    ),
                    highlightColor: const Color.fromARGB(255, 254, 254, 254),
                    onPressed: () {

                      Navigator.pop(context);

                    },
                  ),
                  //Espacio entre fecha y texto
                  SizedBox(width: getProportionateScreenHeight(32)),
                  Row(children: [
                    Text("Agregar galeria", style: headingStyleTwo),
                  ]),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              GalleryAdd(),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
            ],
          ),
        ),
      ),
    ));
  }
}
