import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.text, this.press, this.color})
      : super(key: key);
  final String? text;
  final Function? press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenHeight(160),
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: const BorderSide(
            color:
                kPrimaryColor, // Cambia el color del borde según tus preferencias
            width: 1.0, // Ajusta el ancho del borde según tus preferencias
          ),
          backgroundColor: color,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: const Color.fromARGB(255, 38, 38, 38),
          ),
        ),
      ),
    );
  }
}
