import 'package:experiencias_magicas/screens/home/components/day_screen.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardActivity extends StatelessWidget {
  CardActivity({
    Key? key,
    required this.text,
    required this.id,
    this.press,
    this.longPress,
  }) : super(key: key);

  final String text;
  final int id;
  final VoidCallback? press, longPress;

  Future<void> takeImages() async {
    // final imagePicker = ImagePicker();
    // final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    // setState(() async {
    //   if (pickedImage != null) {
    //     isShowImage = true;
    //     idCompraImg = idCompra;
    //     //_image contiene la iomagen tomada de camara
    //     _image = File(pickedImage.path);
    //     //ontener nombre de la imagen seleccionada para asignarla a la ruta de imagen comprimida
    //     nombreImage = pickedImage.path.split('/').last;

    //     //comprimiendo imagen de camara
    //       final compressedFile = await FlutterImageCompress.compressAndGetFile(
    //         pickedImage.path,
    //         "$compressedImagePath/$nombreImage.jpg",
    //         quality: 20,
    //       );
    //     //comprimir imagen
    //     print('Comprimiendo imagen camara');
    //     if (compressedFile != null) {
    //         setState(() {
    //           File file = File(compressedFile.path);
    //           //agregando imagenes comprimidas al arreglo para mostrar en vista
    //             files.add(file);
    //             print('Agregando imagenes comprimidas a lista FILES: $files');
    //             });
    //             print('Tamaño imagen original camara $nombreImage');
    //             print(await pickedImage.length());
    //             print('Tamaño imagen comprimida camara $nombreImage');
    //             print(await compressedFile.length());
    //     }
    //     //cargar arreglo de imagenes tipo String para cargar en API
    //     if (files.isNotEmpty) {
    //       for (File imgFile in files) {
    //         imagesPath.add(imgFile.path);
    //         arrayImagenes = true;
    //       }

    //     }
    //   }
    // });
  }

  Future<void> selectImages() async {
    // final picker = ImagePicker();
    // final pickedImages = await picker.pickMultiImage();
    // if (pickedImages != null) {
    //   setState(() {
    //     imagesPath = pickedImages.map((image) => image.path).toList();
    //     isShowImage = true;
    //     idCompraImg = idCompra;
    //   });

    //     for(XFile img in pickedImages){
    //       File file = File(img.path);
    //       //ontener nombre de la imagen seleccionada para asignarla a la ruta de imagen comprimida
    //         nombreImage = file.path.split('/').last;
    //       //comprimiendo imagenes de galeria
    //       final compressedFile = await FlutterImageCompress.compressAndGetFile(
    //         file.path,
    //         "$compressedImagePath/$nombreImage.jpg",
    //         quality: 20,
    //       );

    //       if (compressedFile != null) {
    //         setState(() {
    //           File file = File(compressedFile.path);
    //           //agregando imagenes comprimidas al arreglo para mostrar en vista
    //             files.add(file);
    //             print('Agregando imagenes comprimidas a lista FILES: $files');

    //           //agregando imagenes de camara a imagesPath
    //             if (files.isNotEmpty) {
    //               for (File imgFile in files) {
    //                 imagesPath.add(imgFile.path);
    //                 arrayImagenes = true;
    //                 print('imagesPath camara: $imagesPath');
    //               }

    //             }

    //             });

    //             print('Tamaño imagen original $nombreImage');
    //             print(await file.length());
    //             print('Tamaño imagen comprimida $nombreImage');
    //             print(await compressedFile.length());
    //       }

    //     }

    // }
    // //Convierte el path String en Objetos File

    // // for (String path in imagesPath) {
    // //   File file = File(path);
    // //   files.add(file);
    // // }

    // if (files != null) {
    //   arrayImagenes = true;
    // }
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
                            child: Image.asset(
                              "assets/images/splash_3.jpeg",
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
                                contentPadding:  EdgeInsets.only(
                                    bottom: 5, top: 0, left: 10, right: 10),
                                isDense: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: text,
                                labelStyle:  TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
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
                              // descripReport = newValue!;
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
