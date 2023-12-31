import 'package:experiencias_magicas/screens/models/product.dart';
import 'package:flutter/material.dart';

class ShopProduct extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const ShopProduct(
    this.product, {
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            ShopProductDisplay(
              product,
              onPressed: onRemove,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ShopProductDisplay(this.product, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Stack(children: <Widget>[
        Positioned(
          left: 25,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Transform.scale(
              scale: 1,
              child: Image.asset('assets/images/splash_3.jpeg'),
            ),
          ),
        ),
        // Positioned(
        //   left: 50,
        //   top: 5,
        //   child: SizedBox(
        //       height: 80,
        //       width: 80,
        //       child: Image.asset(
        //         '${product.image}',
        //         fit: BoxFit.contain,
        //       )),
        // ),
        Positioned(
          right: 10,
          bottom: 120,
          child: Align(
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Color.fromARGB(255, 202, 47, 47),
                size: 45,
              ),
              onPressed: onPressed,
            ),
          ),
        )
      ]),
    );
  }
}
