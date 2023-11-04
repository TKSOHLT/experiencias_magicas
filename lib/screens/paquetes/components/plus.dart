import 'package:experiencias_magicas/screens/paquetes/components/paquetes_form.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';


class Plus extends StatefulWidget {
  const Plus();

  @override
  _PlusState createState() => _PlusState();
}

class _PlusState extends State<Plus> {

  Widget build(BuildContext context) {
    return Column(
        children: [
          nombreTextField(),
          // horaFinalTextField(),
        ],
    );
  }

  Padding nombreTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Además: "),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              // controller: importeUtiController,
              decoration: InputDecoration(
                hintText: "Actividad",
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
              ),
              onChanged: (newValue) {
                // isImportUti = true;
              },

              onSaved: (newValue) => plus?.add(newValue!),

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

  Padding horaInicioTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Hora de inicio: "),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              // controller: importeUtiController,
              decoration: InputDecoration(
                hintText: "Hora de inicio",
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
