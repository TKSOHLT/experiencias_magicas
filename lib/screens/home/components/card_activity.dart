import 'dart:io';

import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/request/api_request.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/screens/home/components/day_screen.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class CardActivity extends StatefulWidget {
  CardActivity(
      {Key? key,
      required this.text,
      required this.id,
      this.press,
      this.longPress,
      required this.cantidadActividadesServidor,
      required this.photo})
      : super(key: key);

  final String text;
  final String photo;
  final int id;
  final int cantidadActividadesServidor;
  final VoidCallback? press, longPress;

  @override
  State<CardActivity> createState() => _CardActivityState();
}

class _CardActivityState extends State<CardActivity> {
  PageController _controller = PageController(keepPage: true);

  String idFoto = "";
  bool isLoading = true;
  bool arrayImagenes = false;
  String nombreImage = "";
  List<String> imagesPath = [];
  List<File> files = [];
  String compressedImagePath = "/storage/emulated/0/Download/";

  Future<void> cargarImagenes() async {
    imagenesServidor = [];

    parametros = {"opcion": "5.1"};

    var respuesta = await peticiones(parametros);
    if (respuesta != "err_internet_conex") {
      setState(() {
        if (respuesta == 'empty') {
          imagenesServidor = [];
          isLoading = false;
        } else {
          for (int i = 0; i < respuesta.length; i++) {
            imagenesServidor.add("$urlImages${respuesta[i]['photo']}");
          }
          isLoading = false;
        }
      });
    } else {}
  }

  Future<void> selectImages() async {
    String idTemp = "";
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        imagesPath = pickedImages.map((image) => image.path).toList();
      });

      for (XFile img in pickedImages) {
        File file = File(img.path);
        //ontener nombre de la imagen seleccionada para asignarla a la ruta de imagen comprimida
        nombreImage = file.path.split('/').last;
        //comprimiendo imagenes de galeria
        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          file.path,
          "$compressedImagePath/$nombreImage.jpg",
          quality: 100,
        );

        if (compressedFile != null) {
          setState(() {
            File file = File(compressedFile.path);
            //agregando imagenes comprimidas al arreglo para mostrar en vista
            files.add(file);

            //agregando imagenes de camara a imagesPath
            if (files.isNotEmpty) {
              for (File imgFile in files) {
                imagesPath.add(imgFile.path);
                arrayImagenes = true;
              }
            }
          });
          for (File img in files) {
            idTemp = await agregarImagenes(img);
          }

          setState(() {
            idFoto = idTemp;
            print("id de nueva foto: $idFoto");
          });
        }
      }
    }
    //Convierte el path String en Objetos File

    // for (String path in imagesPath) {
    //   File file = File(path);
    //   files.add(file);
    // }

    if (files != null) {
      arrayImagenes = true;
    }
  }

  Future<void> takeImages() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    // setState(() async {
    if (pickedImage != null) {
      //_image contiene la iomagen tomada de camara
      //ontener nombre de la imagen seleccionada para asignarla a la ruta de imagen comprimida
      nombreImage = pickedImage.path.split('/').last;

      //comprimiendo imagen de camara
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        pickedImage.path,
        "$compressedImagePath/$nombreImage.jpg",
        quality: 100,
      );
      //comprimir imagen
      print('Comprimiendo imagen camara');
      if (compressedFile != null) {
        setState(() {
          File file = File(compressedFile.path);
          //agregando imagenes comprimidas al arreglo para mostrar en vista
          files.add(file);
        });
      }
      //cargar arreglo de imagenes tipo String para cargar en API
      if (files.isNotEmpty) {
        for (File imgFile in files) {
          imagesPath.add(imgFile.path);
          arrayImagenes = true;
        }
      }
    }
    setState(() {});
    // });
  }

  Future<void> compressImageS(File originalImage) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      originalImage.path,
      "$compressedImagePath/file1.jpg",
      quality: 100,
    );

    if (compressedFile != null) {
      setState(() {
        File file = File(compressedFile.path);
        //SE ALMACENA LA IMAGEN COMPRIMIDA EN COMPRESSIMAGE
        //compressedImage = file;

        //agregando imagenes comprimidas al arreglo para mostrar en vista
        //files.add(file);
      });
    }
  }

  //Funcion que convierte un path string a path file
  ////File imageFile = await convertPathToFile(imagePath);
  Future<File> convertPathToFile(String imagePath) async {
    return File(imagePath);
  }

  //Funcion que recibe un array de paths String y devuelve un array de Objetos Files
  //List<File> files = convertPathsToFiles(paths);
  List<File> convertPathsToFiles(List<String> paths) {
    List<File> files = [];

    for (String path in paths) {
      File file = File(path);
      files.add(file);
    }
    return files;
  }

  //Variables a enviar a la API
  String? nombre;

  @override
  Widget build(BuildContext context) {
    var styleStatus;

    return
        // GestureDetector(
        //   onLongPress: longPress,
        //   child:
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            padding: const EdgeInsets.all(20),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15)),
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
          ),
          onPressed: () {},
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          editItinerary ? opciones(context) : {};
                        },
                        child: Container(
                          width: getProportionateScreenWidth(100),
                          height: getProportionateScreenHeight(100),
                          child: ClipOval(
                            child: widget.photo != ""
                                ? Image.network(
                                    "$urlImages${widget.photo}",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  )
                                : Image.asset(
                                    "assets/images/sinfoto.jpeg",
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(30)),
                      //Editar
                      SizedBox(
                        // height: getProportionateScreenHeight(30),
                        width: getProportionateScreenWidth(160),
                        child: TextFormField(
                            enabled: editItinerary,
                            scrollPadding: const EdgeInsets.all(10),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                contentPadding: EdgeInsets.only(
                                    bottom: 5, top: 0, left: 10, right: 10),
                                isDense: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: widget.text,
                                labelStyle: styleLblHome,
                                alignLabelWithHint: true,
                                border: InputBorder.none),
                            onChanged: (newValue) {
                              return;
                            },
                            validator: (newValue) {
                              if (newValue!.isEmpty) {
                                return descripReportError;
                              }
                              return null;
                            },
                            onSaved: (newValue) {

                              //validador con nuevo dia
                              if (nuevoItinerario) {
                                newActividades[widget.id + 1].actividad =
                                    newValue;

                                newActividades[widget.id + 1].id_foto = idFoto;

                              } else {

                                if (widget.id >= widget.cantidadActividadesServidor &&
                                    newActividades.isNotEmpty) {
                                  newActividades[widget.id -
                                          widget.cantidadActividadesServidor]
                                      .actividad = newValue;

                                  newActividades[widget.id -
                                          widget.cantidadActividadesServidor]
                                      .id_foto = idFoto;
                                }
                              }
                            },
                            maxLines: 3,
                            minLines: 1),
                      )
                    ],
                  ),
                  // const Row(
                  //   children: [
                  //estado de la compra
                  // ],
                  // ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          )),
      // ),
    );
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(children: [
                //--------------------------------------------------------InkWell de imagen desde camara--------------------------------------------------------
                InkWell(
                  onTap: () async {
                    takeImages();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Tomar una foto",
                              style: TextStyle(fontSize: 16),
                            )),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //--------------------------------------------------------InkWell de imagen desde galeria--------------------------------------------------------
                InkWell(
                  onTap: () async {
                    //Seleccionar multiples imagenes
                    await selectImages();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Escoger de galería",
                              style: TextStyle(fontSize: 16),
                            )),
                            Icon(
                              Icons.photo_library,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
