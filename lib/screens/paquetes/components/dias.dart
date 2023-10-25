import 'package:experiencias_magicas/screens/paquetes/components/actividades.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class Dias extends StatefulWidget {
  const Dias();

  @override
  _DiasState createState() => _DiasState();
}

class _DiasState extends State<Dias> {
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text("Dia 1  Actividades"),
          lugarTextField(),

          Actividades(),

          SizedBox(height: getProportionateScreenHeight(10),)
        ],
      ),
    );
  }
  Padding lugarTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Lugar: "),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              // controller: importeUtiController,
              decoration: InputDecoration(
                hintText: "Lugar",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              onChanged: (newValue) {
                // isImportUti = true;
              },
              validator: (newValue) {
                if (newValue!.isEmpty) {
                  return;
                }
                return null;
              },
              // onSaved: (newValue) => asientos = newValue,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.allow(
              //       RegExp('[0-9.([0-9)?]')), // Limita a dígitos solamente
              // ],
            ),
          )
        ],
      ),
    );
  }

}
