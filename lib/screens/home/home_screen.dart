import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String routeName = "/home";

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
        child: const Body(),
      ),
    );
  }
}

//Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  Navigator.push(context, materialRoute);
}
