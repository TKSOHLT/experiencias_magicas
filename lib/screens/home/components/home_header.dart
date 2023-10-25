import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/screens/cart/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

DateTime date = DateTime.now(); // Fecha actual

class HomeHeader extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeHeader(
    this.scaffoldKey,);

  @override
  State<HomeHeader> createState() => _HomeHeaderState(scaffoldKey);
}

class _HomeHeaderState extends State<HomeHeader> {    
      _HomeHeaderState(this.scaffoldKey);
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  @override
  void initState() {
    // cargarNumeroNotificaciones();
    super.initState();
  }

  // Muestra un CupertinoModalPopup
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // El margen inferior se proporciona para alinear la ventana emergente encima del sistema
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Background color del modal
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Widget SafeArea para evitar superposiciones del sistema
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  // widgetNofiticaciones = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Carrito
          IconButton(
            onPressed: () async {
              scaffoldKey.currentState!.showBottomSheet((context) {
                return ShopBottomSheet();
              });
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 40,
            ),
          ),

          //Notificaciones
          SizedBox(
            height: 10,
            width: 10,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                if (lblTotalNotifications >= 1) ...[
                  Positioned(
                    right: getProportionateScreenWidth(-45),
                    bottom: getProportionateScreenHeight(5),
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          lblTotalNotifications.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
          IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.notifications_active_sharp,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
