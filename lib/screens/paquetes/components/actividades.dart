import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class Actividades extends StatefulWidget {
  const Actividades();

  @override
  _ActividadesState createState() => _ActividadesState();
}

class _ActividadesState extends State<Actividades> {
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          nombreTextField(),
          horaInicioTextField(),
          horaFinalTextField(),
        ],
      ),
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
              Text("Nombre de actividad: "),
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

    Padding horaFinalTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Hora de finalizacion: "),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(35),
            width: getProportionateScreenWidth(120),
            child: TextFormField(
              // controller: importeUtiController,
              decoration: InputDecoration(
                hintText: "Hora de finalizacion",
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
