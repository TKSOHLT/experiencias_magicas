import 'dart:io';

import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/request/api_request.dart';
import 'package:experiencias_magicas/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({required this.foto, Key? key, required this.callback})
      : super(key: key);

  final foto;
  final callback;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String idFoto = "";
  bool isLoading = true;
  bool arrayImagenes = false;
  String nombreImage = "";
  List<String> imagesPath = [];
  List<File> files = [];
  String compressedImagePath = "/storage/emulated/0/Download/";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          opciones(context);
        },
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -50,
                bottom: 17,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider("$urlImages${widget.foto}"),
                    // backgroundColor: kbackgroundImageProfile,
                  ),
                ),
              )
            ],
          ),
        ));
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

  Future<void> takeImages() async {
    String idTemp = "";

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

        for (File img in files) {
          idTemp = await agregarImagenes(img);
        }

        setState(() {
          idFoto = idTemp;
        });

        parametros = {
          "opcion": "1.4",
          "id_usuario": await getUserId(),
          "id_foto": idFoto
        };

        var respuesta = await peticiones(parametros);

        switch (respuesta) {
          case "exito":
            if (mounted) {
              Navigator.pop(context);
              QuickAlertSuccess(
                  context, "¡Se ha modificado la imagen con éxito!");
              
              widget.callback();
            }
            break;
          case "error":
            if (mounted) {
              Navigator.pop(context);
              QuickAlertError(
                  context, "¡Ha ocurrido un error al hacer la petición!");
            }
            break;
        }
      }
    }
    setState(() {});
    // });
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
          });

          parametros = {
            "opcion": "1.4",
            "id_usuario": await getUserId(),
            "id_foto": idFoto
          };

          var respuesta = await peticiones(parametros);

          switch (respuesta) {
            case "exito":
              if (mounted) {
                Navigator.pop(context);
                QuickAlertSuccess(
                    context, "¡Se ha modificado la imagen con éxito!");
                
                widget.callback();
              }
              break;
            case "error":
              if (mounted) {
                Navigator.pop(context);
                QuickAlertError(
                    context, "¡Ha ocurrido un error al hacer la petición!");
              }
              break;
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
}
