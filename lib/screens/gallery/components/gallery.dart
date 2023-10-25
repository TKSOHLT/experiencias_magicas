//===========================================================================//
//============================Cuerpo de vista buy ===========================//
//===========================================================================//

import 'dart:async';

import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';

class Gallery extends StatefulWidget {
  const Gallery({
    super.key,
  });

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
//variables para almacenar los valores desde la API
  String lblTitle = "";
  String? producto;
  String? estado;
  String? idCompra;
  bool isLoading = true;
  List<Widget> widgetCardActivity = [];

  final List<String?> errors = [];

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
    return Scaffold(
      body: Container(
          //decoration: const BoxDecoration(gradient: kPrimaryGradientColor),
          child: RefreshIndicator(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    // const HomeHeader(),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Centra el icono a la izquierda
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color.fromARGB(255, 18, 17, 17),
                                    size: 25.0,
                                  ),
                                  highlightColor:
                                      const Color.fromARGB(255, 254, 254, 254),
                                  onPressed: () {
                                    // _createOnPressed(context, ReceivedBuyScreen(idCompra: idCompra, estatus: status));
                                    Navigator.pop(context);
                                  },
                                ),
                                //Espacio entre fecha y texto
                                SizedBox(
                                    width: getProportionateScreenHeight(110)),
                                const Text(
                                  "Textoo",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                            GalleryImage(
                              numOfShowImages: 6,
                              imageUrls: const [
                                "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
                                "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
                                "https://wallpapers.com/images/featured/2ygv7ssy2k0lxlzu.jpg",
                                "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
                                "https://media.cntraveller.com/photos/611bf0b8f6bd8f17556db5e4/1:1/w_2000,h_2000,c_limit/gettyimages-1146431497.jpg",
                                "https://img.freepik.com/premium-photo/fantastic-view-kirkjufellsfoss-waterfall-near-kirkjufell-mountain-sunset_761071-868.jpg",
                                "https://www.travelandleisure.com/thmb/KLPvXakEKLGE5AY2jVyovl3Md1k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/iceland-BEAUTCONT1021-b1aeafa7ac2847a484cbca48d3172b6c.jpg",
                                "https://w0.peakpx.com/wallpaper/265/481/HD-wallpaper-nature.jpg",
                                "https://e0.pxfuel.com/wallpapers/163/906/desktop-wallpaper-beautiful-nature-with-girl-beautiful-girl-with-nature-and-moon-high-resolution-beautiful.jpg",
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              onRefresh: () async {})),
    );
  }
}
