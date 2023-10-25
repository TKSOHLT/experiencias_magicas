import 'package:experiencias_magicas/components/datepicker.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String? userName;
String? phone;
String? email;
String? password;
bool hidePass = true;

class BuyHeader extends StatefulWidget {
  @override
  _BuyHeaderState createState() => _BuyHeaderState();
}

class _BuyHeaderState extends State<BuyHeader> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  bool loading = false;
  void addError({String? error}) {
    if (!errors.contains(error)) {
      if (mounted) {
        setState(() {
          errors.add(error);
        });
      }
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // buildUserNameFormField(),
          buildDatePickerField(),

          SizedBox(height: getProportionateScreenHeight(30)),

          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  Column buildDatePickerField() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Text(
              "Fechas disponibles",
              textAlign: TextAlign.center,
            )),
            Expanded(child: DatePicker())
          ],
        )
      ],
    );
  }

  Column buildPhoneFormField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child:
                    Text("Lugares disponibles", textAlign: TextAlign.center)),
            Expanded(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(214, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 100,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        '10',
                                        textAlign: TextAlign.center,
                                      )))
                            ]))))
          ],
        )
      ],
    );
  }

  Column buildPasswordFormField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Text("¿Cuantas personas viajan?",
                    textAlign: TextAlign.center)),
            Expanded(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(214, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: TextField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            contentPadding: EdgeInsets.only(
                                bottom: 5, top: 0, left: 10, right: 10),
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                            alignLabelWithHint: true,
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                    )))
          ],
        )
      ],
    );
  }
}
