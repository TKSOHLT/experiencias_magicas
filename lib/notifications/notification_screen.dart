


import 'package:experiencias_magicas/notifications/components/body.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        body: Body(),
        //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
        //floatingActionButton: MenuCircular(routeName: routeName, context: context)
        
      );
  }
}
