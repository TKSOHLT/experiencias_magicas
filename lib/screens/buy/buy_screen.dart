
import 'package:experiencias_magicas/components/navbar.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:experiencias_magicas/screens/buy/components/body.dart';


class BuyScreen extends StatefulWidget {
  static String routeName = "/buy";

  const BuyScreen({
    super.key,
  });

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  static String routeName = "/buy";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: getProportionateScreenHeight(1000),
        decoration: const BoxDecoration(
          gradient: kPrimaryGradientColor,
        ),
        child: Body(),
      ),
      // bottomNavigationBar: NavBar()
    );
  }
}

//Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  Navigator.push(context, materialRoute);
}
