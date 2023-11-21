import 'package:experiencias_magicas/components/shop_product.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/models/product.dart';
import 'package:flutter/material.dart';

class ShopBottomSheet extends StatefulWidget {
  @override
  _ShopBottomSheetState createState() => _ShopBottomSheetState();
}

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Widget confirmButton = InkWell(
      onTap: () async {
        Navigator.of(context).pop();

        parametros = {
          "opcion": "4",
          "id_paquete": products[0].id_paquete,
          "id_usuario": "0",
          "lugares": products[0].places.toString(),
          "total": products[0].price.toString()
        };

        var respuesta = await peticiones(parametros);

        switch (respuesta) {
          case "exito":
            if (mounted) {
              QuickAlertSuccess(context,
                  "¡Se generado la compra, espera el baucher en las notificaciones!");

              setState(() {
                products.remove(products[0]);
              });
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
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => CheckOutPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 20
                : MediaQuery.of(context).padding.bottom),
        child: Center(
            child: new Text("Comprar",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
        decoration: BoxDecoration(
            gradient: kPrimaryGradientColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
      ),
    );

    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color.fromARGB(255, 48, 45, 45),
                  size: 50.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 48,
              ),
            ),
            SizedBox(
                height: 300,
                child: products.isNotEmpty
                    ? ShopProduct(
                        products[0],
                        onRemove: () {
                          setState(() {
                            products.remove(products[0]);
                          });
                        },
                      )
                    : Container()),
            confirmButton
          ],
        ));
  }
}
