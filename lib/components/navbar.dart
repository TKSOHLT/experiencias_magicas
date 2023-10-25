import 'package:experiencias_magicas/screens/buy/buy_screen.dart';
import 'package:experiencias_magicas/screens/home/home_screen.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar(
      {super.key, required this.onIndexChanged, required this.currentIndex});
  final Function(int) onIndexChanged;
  final int currentIndex;

  @override
  // ignore: no_logic_in_create_state
  State<NavBar> createState() =>
      _NavBarState(onIndexChanged: onIndexChanged, currentIndex: currentIndex);
}

class _NavBarState extends State<NavBar> {
  Widget? _child;
  _NavBarState({required this.onIndexChanged, required this.currentIndex});
  final Function(int) onIndexChanged;
  final int currentIndex;

  @override
  void initState() {
    _child = const HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluidNavBar(
        scaleFactor: 1.1,
        icons: [
          FluidNavBarIcon(svgPath: "assets/icons/Shop.svg"),
          FluidNavBarIcon(svgPath: "assets/icons/Gallery.svg"),
          FluidNavBarIcon(svgPath: "assets/icons/Home.svg"),
          FluidNavBarIcon(svgPath: "assets/icons/Chat bubble Icon.svg"),
          FluidNavBarIcon(svgPath: "assets/icons/User.svg"),
        ],
        onChange: (index) => _handleNavigationChange(index),
        defaultIndex: 2,
        style: const FluidNavBarStyle(
          barBackgroundColor: Color.fromARGB(255, 253, 241, 241),
          iconBackgroundColor: Color.fromARGB(255, 253, 241, 241),
          iconUnselectedForegroundColor: Color.fromARGB(255, 3, 4, 3),
        ));
  }

  void _handleNavigationChange(int index) {
    print(index);
    widget.onIndexChanged(index); // Llamar a la función del widget padre

    setState(() {
      // switch (index) {
      //   case 0:
      //     _child = const BuyScreen();
      //     break;
      //   case 1:
      //     // _child = HomeScreen();
      //     break;
      //   case 2:
      //     _child = HomeScreen();
      //     break;
      //   case 3:
      //     // _child = HomeScreen();
      //     break;
      //   case 4:
      //     // _child = HomeScreen();
      //     break;
      // }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
