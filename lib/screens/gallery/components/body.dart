//==============================================================================//
//============================Cuerpo de vista gallery===========================//
//==============================================================================//

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/request/api_request.dart';
import 'package:experiencias_magicas/screens/gallery/components/gallery.dart';
import 'package:experiencias_magicas/screens/gallery/components/gallery_form.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:gridded_pageview/gridded_pageview.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController _controller = PageController(keepPage: true);

  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

//variables booleanas para el manejo del estado de reporte y carga de imagen
  bool isShowImage = false;
  bool recargarImagenes = false;
  //bool imagenCargada = false;
  bool arrayImagenes = false;
  bool arrayImagenesCamera = false;

  File? originalImage;
  File? compressedImage;
  String compressedImagePath = "/storage/emulated/0/Download/";
  String? nombreImage;

  // List<Usuario> admins = [];

  //almacena path imagenes de galeria en String
  List<String> imagesPath = [];
  //Almacena el objeto File de la imagen de galeria
  List<File> files = [];

  //almacena path imagenes de camara en String
  //List<String> imagesPathCamera = [];
  //Almacena el objeto File de la imagen de camara
  //List<File> filesCamera = [];

  //variables locales que almacenan lo que el usuario ingrese
  String? descripcion;
  String? nombre;
  String? nombreImagen;
  //variables que almacenan el resultado de la seleccion de la imagen
  String? imageURL;
  String? foto;

  bool isLoading = true;
  //Carga de datos de usuario mandadero desde controlador
  @override
  void initState() {
    super.initState();
    cargarImagenes();
    //Reload cada dos minutos
    reload();
  }

  void reload() {
    Timer(const Duration(seconds: 120), () {
      reload();
    });
  }

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
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        imagesPath = pickedImages.map((image) => image.path).toList();
        isShowImage = true;
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
          var response = "";

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
            response = await agregarImagenes(img);
          }

          switch (response) {
            case "error":
              if (mounted) {
                Navigator.pop(context);
                QuickAlertError(
                    context, "¡Ha ocurrido un error al hacer la petición!");
              }
              break;
            default:
              if (mounted) {
                Navigator.pop(context);
                QuickAlertSuccess(
                    context, "¡Se han guardado las imagenes con éxito!");

                setState(() {
                  isLoading = true;
                  cargarImagenes();
                });
              }
          }
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
      isShowImage = true;
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
        var response = "";

        for (File imgFile in files) {
          imagesPath.add(imgFile.path);
          arrayImagenes = true;
        }

        for (File img in files) {
          response = await agregarImagenes(img);
        }

        switch (response) {
          case "error":
            if (mounted) {
              Navigator.pop(context);
              QuickAlertError(
                  context, "¡Ha ocurrido un error al hacer la petición!");
            }
            break;
          default:
            if (mounted) {
              Navigator.pop(context);
              QuickAlertSuccess(
                  context, "¡Se han guardado las imagenes con éxito!");

              setState(() {
                isLoading = true;
                cargarImagenes();
              });
            }
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: SpinKitCubeGrid(color: Colors.white, size: 140),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
              onLongPress: () {
                addFoto(context);
              },
              child: Column(
                children: [
                  GalleryImage(
                    titleGallery: "Experiencias mágicas",
                    numOfShowImages: imagenesServidor.length > 15
                        ? 15
                        : imagenesServidor.length,
                    imageUrls: imagenesServidor,
                  ),
                  // Text("Holi")
                ],
              )));
    }
  }

  addFoto(context) {
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
