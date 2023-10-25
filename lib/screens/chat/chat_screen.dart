
import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/chat/components/body.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";

  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static String routeName = "/chat";

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
