import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class ChatRow extends StatelessWidget {
  const ChatRow({
    Key? key,
    required this.text,
    required this.status,
    required this.name,
    required this.hour,
    required this.icon,
    required this.allText,
    this.press,
    this.longPress,
  }) : super(key: key);

  final String text, status, name, hour, icon, allText;
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
                    child: Image.asset(
                      "assets/images/splash_3.jpeg",
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
                          maxWidth: getProportionateScreenHeight(250)),
                      child: Text(
                        "asaosdjalsknflsdknfslkdnflsknflsdnflsdfsdkfnsdlkfnsldkfnlskdnflskdnflksdnflksndfsldkfnsldknfslkdnflskndflksndlkfnslkdnflskndflskdnflsdnflskdnflksndflsndlfknsdfksdf",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.delivery_dining,
                                color: Colors.amber),
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: getProportionateScreenWidth(80),),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const Icon(Icons.star, color: Colors.amber),
                            const Icon(Icons.star, color: Colors.amber),
                            const Icon(Icons.star, color: Colors.amber),
                            const Icon(Icons.star,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
