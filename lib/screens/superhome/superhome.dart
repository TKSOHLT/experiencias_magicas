import 'package:experiencias_magicas/components/navbar.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/buy/buy_screen.dart';
import 'package:experiencias_magicas/screens/chat/chat_screen.dart';
import 'package:experiencias_magicas/screens/gallery/gallery_screen.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/screens/home/home_screen.dart';
import 'package:experiencias_magicas/screens/profile/profile_screen.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class SuperHomeScreen extends StatefulWidget {
  const SuperHomeScreen({
    super.key,
  });

  @override
  State<SuperHomeScreen> createState() => _SuperHomeScreenState();
}

class _SuperHomeScreenState extends State<SuperHomeScreen> {
  int _currentIndex =
      2; // Establece el índice inicial en 2 (puedes cambiarlo según tus necesidades)
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Resto del código de _HomeScreenState...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      body: Column(
        children: [
          _currentIndex != 4 ? Container(
            constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight,
                maxWidth: SizeConfig.screenWidth),
            // height: getProportionateScreenHeight(1000),
            decoration: const BoxDecoration(
              gradient: kPrimaryGradientColor,
            ),
            child: Padding(padding: EdgeInsets.only(top: getProportionateScreenHeight(35)), child: HomeHeader(_scaffoldKey),)
            
          ) : Container(),
          Container(
            constraints: BoxConstraints(
                maxHeight: _currentIndex == 4 ? SizeConfig.screenHeight : SizeConfig.screenHeight * 0.9,
                maxWidth: SizeConfig.screenWidth),
            // height: getProportionateScreenHeight(1000),
            decoration: const BoxDecoration(
              gradient: kPrimaryGradientColor,
            ),
            child: IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                // Añade las vistas que deseas mostrar aquí
                const BuyScreen(),
                const GalleryScreen(),
                const HomeScreen(),
                const ChatScreen(),
                ProfileScreen(),
                // Agrega más vistas si es necesario
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index; // Actualiza el índice seleccionado
          });
        },
        currentIndex: _currentIndex, // Pasa el índice seleccionado al NavBar
      ),
    );
  }
}
