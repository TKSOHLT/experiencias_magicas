import 'dart:io';

import 'package:experiencias_magicas/components/custom_button.dart';
import 'package:experiencias_magicas/components/datepicker.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class GalleryAdd extends StatefulWidget {
  const GalleryAdd({super.key});

  @override
  _GalleryAddState createState() => _GalleryAddState();
}

class _GalleryAddState extends State<GalleryAdd> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
  //Variable local para almacenar el id_usuario admin a quien será enviado una notificación
  String? id_usuario_admin;

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
  String? idCompraImg;
  //============================VARIABLES DEL CALCULO DEL MONTO SOBRANTE================================
//Instancias para el calculo del monto sobrante
  TextEditingController costoController = TextEditingController();
  TextEditingController importeUtiController = TextEditingController();
  TextEditingController importeSobController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  //listener para escuchar el cambio en los campos de entrada de montos
  @override
  void initState() {
    super.initState();
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
          quality: 20,
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
        quality: 20,
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
      quality: 10,
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

  //==================================Funciones de Ruta en vistas======================================
  //Esta función vuelve a crear la ruta una vez se desheche
  void _createOnPressed(BuildContext context, StatelessWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }

  void _createOnPressedStateful(BuildContext context, StatefulWidget route) {
    Route materialRoute = MaterialPageRoute(builder: (context) => route);
    Navigator.push(context, materialRoute);
  }

  //==================================================================================================
  @override
  void dispose() {
    // Limpia los controladores al finalizar
    costoController.dispose();
    importeUtiController.dispose();
    resultController.dispose();
    super.dispose();
  }

//==========================================Maneko de errores==========================================
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
  //==================================================================================================

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            //altura proporcional a la pantalla
            height: getProportionateScreenHeight(600),
            //anchura del form proporcional a la pantalla
            width: getProportionateScreenWidth(400),
            //padding: da espaciado interno porporcional a la pantalla
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(0)),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 246, 246),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 70,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  nombreLugar(),
                  descripcionLugar(),
                  // costoPaquete(),
                  // asientosPaquete(asientos),

                  // Dias(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seleccione las fotos"),
                      iconAddImageBuy(context)
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(14)),
                  RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      return Future<void>.delayed(const Duration(seconds: 3));
                    },
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(files.length, (index) {
                              //print('ruta de imagen en card: ${imagesPath[index]}');
                              return recargarImagenes == true
                                  ? cardImage(index)
                                  : cardImage(index);
                            })
                          ],
                        )),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
          ),
          button(context, isShowImage),
        ],
      ),
    );
  }

//=================================================FUNCIONES DE VISTA=================================================
  Padding button(context, bool isShowImage) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            CustomButton(
                text: "Generar",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(descripcion);
                    print(nombre);
                    print(files);
                  }
                })
          ]),
        ],
      ),
    );
  }

  Padding nombreLugar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Nombre de la galeria: ", style: lblStyleColumnForm),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              controller: costoController,
              decoration: InputDecoration(
                hintText: "Galeria",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              onSaved: (newValue) => nombre = newValue!,
            ),
          )
        ],
      ),
    );
  }

  Padding descripcionLugar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Descripción: ", style: lblStyleColumnForm),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              controller: importeUtiController,
              decoration: InputDecoration(
                hintText: "Descripcion",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              onChanged: (newValue) {},
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return;
                }
                return null;
              },
              onSaved: (newValue) => descripcion = newValue,
            ),
          )
        ],
      ),
    );
  }

  Column iconAddImageBuy(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //---------------------Agregar imagen de compra---------------------------------
              IconButton(
                  icon: const Icon(Icons.add_a_photo_sharp),
                  onPressed: () {
                    //_showInkWell = true;
                    opciones(context);
                  })
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(4)),
      ],
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

  //=================================================FIN DE FUNCIONES=================================================
  Padding cardImage(int index) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(6),
          bottom: getProportionateScreenHeight(6)),
      child: SizedBox(
        width: getProportionateScreenWidth(254),
        child: GestureDetector(
          onLongPress: () {
            //eliminar imagen
            showEliminarImagen(index);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: files.indexed.toString(),
                    //imagen proporcionada por el comprador
                    child: Image.file(files[index]),

                    // _image == null
                    //     ? const Text(
                    //         "No se seleccionó ninguna imagen",
                    //         textAlign: TextAlign.center,
                    //       )
                    //     : Image.file(_image!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showEliminarImagen(int index) {
    return showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text("¿Deséa eliminar ésta imagen?",
                style: TextStyle(color: Color.fromARGB(255, 218, 11, 11))),
            //content: const Text("La sesión se cerrará"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(color: Color.fromARGB(255, 23, 21, 21)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Si, eliminar",
                  style: TextStyle(color: Color.fromARGB(255, 218, 11, 11)),
                ),
                onPressed: () async {
                  await imagesPath.removeAt(index);
                  await files.removeAt(index);

                  Navigator.of(context).pop();

                  setState(() {
                    recargarImagenes = true;
                  });

                  // setState(() {
                  //   isLoggedIn = false;
                  // });
                },
              )
            ],
          );
        });
  }
}
