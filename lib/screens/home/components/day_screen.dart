import 'package:experiencias_magicas/components/coustom_nav_bar.dart';
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/enum.dart';
import 'package:experiencias_magicas/screens/home/components/body.dart';
import 'package:experiencias_magicas/screens/home/components/card_activity.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({
    super.key,
  });

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Text("Dia 1"),
          CardActivity(
            text: '',
            status: '',
            name: '',
            hour: '',
            icon: '',
          )
        ],
      ),
    );
  }
}

//Esta función vuelve a crear la ruta una vez se desheche
void _createOnPressed(BuildContext context, StatelessWidget route) {
  Route materialRoute = MaterialPageRoute(builder: (context) => route);
  Navigator.push(context, materialRoute);
}
