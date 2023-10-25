import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardActivity extends StatelessWidget {
  const CardActivity({
    Key? key,
    required this.text,
    required this.status,
    required this.name,
    required this.hour,
    required this.icon,
    this.press,
    this.longPress,
  }) : super(key: key);

  final String text, status, name, hour, icon;
  final VoidCallback? press, longPress;

  @override
  Widget build(BuildContext context) {
    var styleStatus;

    return GestureDetector(
      onLongPress: longPress,
      child: Padding(
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
                        Container(
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
                        SizedBox(width: getProportionateScreenWidth(30)),
                        const Text("Cuevas")
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
      ),
    );
  }
}
