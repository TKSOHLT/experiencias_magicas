import 'package:experiencias_magicas/screens/paquetes/components/paquetes_form.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/material.dart';

class Dias extends StatefulWidget {
  const Dias({required this.noDia});
  final String noDia;

  @override
  _DiasState createState() => _DiasState();
}

class _DiasState extends State<Dias> {
  bool isChecked = false;

  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [

          widgetDia(),

          SizedBox(
            height: getProportionateScreenHeight(10),
          )
        ],
      ),
    );
  }

  Padding widgetDia() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("Día ${widget.noDia}"),
            ],
          ),
          SizedBox(
              height: getProportionateScreenHeight(35),
              width: getProportionateScreenWidth(120),
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                    value ? dias?.add(widget.noDia) : dias?.remove(widget.noDia);
                    print(value);
                    print(dias);

                  });
                },
              ))
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.blue;
  }
}
