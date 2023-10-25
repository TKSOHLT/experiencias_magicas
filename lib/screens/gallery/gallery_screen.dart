import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/screens/gallery/components/body.dart';
import 'package:experiencias_magicas/screens/home/components/home_header.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  static String routeName = "/gallery";

  const GalleryScreen({
    super.key,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  static String routeName = "/gallery";

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
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(42.5)),
              // const HomeHeader(),
              Container(
                constraints: BoxConstraints(maxHeight: SizeConfig.screenHeight * 0.81, maxWidth: SizeConfig.screenWidth),
                child: Body(),
              )
            ],
          )),
      // bottomNavigationBar: NavBar()
    );
  }
}