import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class ChatRow extends StatelessWidget {
  const ChatRow({
    Key? key,
    required this.text,
    required this.name,
    required this.stars,
    required this.image,
    this.press,
    this.longPress,
  }) : super(key: key);

  final String text, name, image;
  final int stars;
  final VoidCallback? press, longPress;

  @override
  Widget build(BuildContext context) {
    var styleStatus;

    // switch (status) {
    //   case "CANCELADO":
    //     styleStatus = lblEstatusCancelado;
    //     break;
    //   case "PENDIENTE":
    //     styleStatus = lblEstatusPendiente;
    //     break;
    //   case "HECHO":
    //     styleStatus = lblEstatusHecho;
    //     break;
    //   case "EN CURSO":
    //     styleStatus = lblEstatusEnCurso;
    //     break;
    //   case "NOTIFICADO":
    //     styleStatus = lblEstatusNotificado;
    //     break;
    // }

    return GestureDetector(
        onLongPress: longPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Color.fromARGB(133, 245, 246, 249),
            ),
            onPressed: press,
            child: Row(
              children: [
                // Imagen en forma de óval
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.solid),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "$urlImages${image}",
                      height:
                          50, // Ajusta el tamaño de la imagen según tus necesidades
                      width:
                          50, // Ajusta el tamaño de la imagen según tus necesidades
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espaciado entre la imagen y el texto
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: getProportionateScreenWidth(240)),
                      child: Text(
                        text,
                        style: styleCardOpinion,
                      ),
                    ),
                    SizedBox(
                        height: 10), // Espaciado entre la imagen y el texto

                    Container(
                      constraints: BoxConstraints(
                          minWidth: getProportionateScreenHeight(250)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.amber),
                              Text(
                                name,
                                style: styleCardOpinionName,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: stars >= 1
                                    ? Colors.amber
                                    : Color.fromARGB(255, 37, 36, 36),
                                size: 25,
                              ),
                              Icon(
                                Icons.star,
                                color: stars >= 2
                                    ? Colors.amber
                                    : Color.fromARGB(255, 37, 36, 36),
                                size: 25,
                              ),
                              Icon(
                                Icons.star,
                                color: stars >= 3
                                    ? Colors.amber
                                    : Color.fromARGB(255, 37, 36, 36),
                                size: 25,
                              ),
                              Icon(
                                Icons.star,
                                color: stars >= 4
                                    ? Colors.amber
                                    : Color.fromARGB(255, 37, 36, 36),
                                size: 25,
                              ),
                              Icon(
                                Icons.star,
                                color: stars >= 5
                                    ? Colors.amber
                                    : Color.fromARGB(255, 37, 36, 36),
                                size: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
