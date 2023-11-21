import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const kPrimaryColor = Color.fromARGB(255, 81, 196, 83);
const kPrimaryLightColor = Color(0xFFFFECDF);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 75, 65, 205), // Color más claro
    Color.fromARGB(255, 81, 196, 110), // Color intermedio
  ],
);

const kPrimaryGradientColorRed = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 178, 150),
      Color.fromARGB(255, 241, 64, 0)
    ]);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final splashStyle1 = TextStyle(
  fontSize: getProportionateScreenWidth(40),
  fontWeight: FontWeight.w900,
  color: const Color.fromARGB(255, 254, 254, 254),
  height: 1.5,
);

final splashStyle2 = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.w500,
  color: const Color.fromARGB(255, 254, 254, 254),
  height: 1.5,
);

final headingStyleTwo = TextStyle(
  fontSize: getProportionateScreenWidth(22),
  fontWeight: FontWeight.bold,
  fontFamily: 'Inter',
  color: Colors.white,
  height: 1.5,
);

final headingStyleThree = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);


final headingStyleFour = TextStyle(
  fontSize: getProportionateScreenWidth(22),
  fontWeight: FontWeight.bold,
  fontFamily: 'Inter',
  color: kPrimaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Ingresa tu correo electrónico.";
const String kInvalidEmailError = "Ingresa un correo electrónico válido.";
const String kPassNullError = "Ingresa tu contraseña.";
const String kShortPassError = "La contraseña es muy corta.";
const String kMatchPassError = "Contraseña no válida.";
const String kNamelNullError = "Ingresa tu nombre.";
const String kPhoneNumberNullError = "Ingresa tu número telefónico.";
const String kAddressNullError = "Ingresa tu dirección.";

// Form generar compra Error
const String kCompradorNullError = "Selecciona un comprador";
const String kLugarNullError = "Escribe el lugar de compra";
const String kProductoNullError = "Escribe un producto";
const String kCantidadNullError = "Escribe una cantidad";
const String kUnidadError = "Selecciona un tipo de unidad";
const String kMontoNullError = "Escribe un monto monetario";
const String kMontoWrongError = "Escribe un monto monetario válido";
final RegExp montoValidatorRegExp = RegExp(r"^\d+(\.\d+)?$");

// Form finalizar compra Error
const String personaRecibeError =
    "Escribe el nombre de quien recibe la compra.";
const String importeUtilizadoError = "Ingresa el importe gastado en la compra.";
const String descripReportError =
    "Menciona los motivos de la compra no finalizada.";
const String imageCompraFinError = "Sube una imagen de la compra.";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

//Todo: Splash screen//
const lblStyleColumnForm = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 16,
    fontWeight: FontWeight.w500);

//Home
final styleLblHome = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
  color: Colors.white,
  height: 1.5,
);

final styleTitleHome = TextStyle(
  fontSize: getProportionateScreenWidth(22),
  fontWeight: FontWeight.w900,
  fontFamily: 'Nunito',
  color: Colors.white,
  height: 2.5,
);

//Cards opinion
final styleCardOpinion = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(233, 34, 34, 34),
  height: 1.5,
);

final styleCardOpinionName = TextStyle(
  fontSize: getProportionateScreenWidth(13),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(197, 34, 34, 34),
  height: 1.5,
);

//Comprar
final styleBuyLabelsHeader = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(231, 240, 240, 240),
  height: 1.5,
);

final styleBuyFecha = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(255, 56, 47, 186),
);

final styleBuyLugares = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(255, 43, 43, 41),
);

final styleBtnBuy = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.w900,
  fontFamily: 'Nunito',
  color: Color.fromARGB(255, 255, 255, 255),
  height: 1.5,
);

final styleDataHeader = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.w900,
  fontFamily: 'Nunito',
  color: Color.fromARGB(255, 0, 0, 0),
  height: 1.5,
);

final styleDataRow = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.w500,
  fontFamily: 'Nunito',
  color: Color.fromARGB(255, 0, 0, 0),
  height: 1.5,
);

final styleBuyCosto = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.w900,
  fontFamily: 'Nunito',
  color: kPrimaryColor,
  height: 1.5,
);

//Perfil de usuario
final styleProfileHeader = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.w900,
  fontFamily: 'Nunito',
  color: Color.fromARGB(255, 240, 255, 240),
  height: 1.5,
);

//Generar evento
final styleEventLblForm = TextStyle(
  fontSize: getProportionateScreenWidth(13),
  fontWeight: FontWeight.w500,
  fontFamily: 'Inter',
  color: Color.fromARGB(231, 41, 40, 40),
  height: 1.5,
);

final styleEventLblHeader = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.w500,
  fontFamily: 'Inter',
  color: Color.fromARGB(255, 41, 40, 40),
  height: 1.5,
);

final styleEventFecha = TextStyle(
  fontSize: getProportionateScreenWidth(13),
  fontWeight: FontWeight.w700,
  fontFamily: 'Inter',
  color: Color.fromARGB(255, 56, 47, 186),
);
