import 'package:experiencias_magicas/constants.dart';
import 'package:experiencias_magicas/controller/controller_principal.dart';
import 'package:experiencias_magicas/firebase_options.dart';
import 'package:experiencias_magicas/global_functions.dart';
import 'package:experiencias_magicas/globals.dart';
import 'package:experiencias_magicas/notifications/components/card_notificacion.dart';
import 'package:experiencias_magicas/routes.dart';
import 'package:experiencias_magicas/screens/splash/splash.dart';
import 'package:experiencias_magicas/screens/superhome/superhome.dart';
import 'package:experiencias_magicas/size_config.dart';
import 'package:experiencias_magicas/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Obtener permisos de notificaciones (Ios)
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //Habilitar el inicio automàtico de FMC en tiempo de ejecución
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String ruta = SplashScreen.routeName;
  String? idTemp;
  bool loading = true;

  Future<void> cargarNotificaciones() async {
    parametros = {"opcion": "6", "id_usuario": await getUserId()};

    var respuesta = await peticiones(parametros);
    if (respuesta != "err_internet_conex") {
      setState(() {
        if (respuesta == 'empty' || respuesta == "error") {
          widgetNofiticaciones = [];
        } else {
          for (int i = 0; i < respuesta.length; i++) {
            widgetNofiticaciones
                .add(SizedBox(height: getProportionateScreenHeight(10)));
            widgetNofiticaciones.add(
              CardNotificacion(
                text: respuesta[i]['message'],
                icon: Icon(
                  Icons.delivery_dining,
                  size: getProportionateScreenHeight(30),
                ),
                press: () {
                  // if (rol != "ADMIN") {
                  //   _createOnPressed(
                  //       context,
                  //       ReceivedBuyScreen(
                  //           idCompra: respuesta[i]['id_compra'].toString(),
                  //           estatus: respuesta[i]['estatus'].toString()));
                  // } else {
                  //   // _createOnPressed(
                  //   //     context,
                  //   //     DetailsPageAdmin(
                  //   //         idCompra: respuesta[i]['id_compra'].toString()));
                  // }
                },
                datetime: respuesta[i]['datetime'],
                id: respuesta[i]['id_notification'].toString(),
              ),
            );
          }

          lblTotalNotifications = (widgetNofiticaciones.length / 2).round();
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      // StatusAlert.show(
      //   context,
      //   duration: const Duration(seconds: 2),
      //   title: 'Error',
      //   subtitle: 'El usuario tiene compras pendientes',
      //   configuration: const IconConfiguration(icon: Icons.error),
      //   maxWidth: 260,
      // );
    }

    // } catch (e) {
    //   //
    // }
  }

  getUserNameTemp() async {
    idTemp = await getUserId();
    rol = await getUserRol() ?? "2";
    print("Rol de usuario:$rol");
    setState(() {
      loading = false;
      idTemp;
    });
  }

  @override
  void initState() {
    //cargar notificaciones desencadena cargar shared preferences
    getUserNameTemp();
    cargarNotificaciones();
    // checkLoggedInStatus();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (idTemp != null) {
      ruta = SuperHomeScreen.routeName;
    } else {
      ruta = SplashScreen.routeName;
    }

    if (loading) {
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_1.jpeg"),
              fit: BoxFit.cover, // La imagen cubrirá todo el contenedor
            ),
          ),
          child: Container(
              constraints: BoxConstraints(maxWidth: 500, maxHeight: 500),
              child: const CircularProgressIndicator(
                  backgroundColor: Colors.white, color: kPrimaryColor)));
    } else {
      return MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
        ],
        color: kPrimaryColor,
        debugShowCheckedModeBanner: false,
        title: 'Test',
        theme: AppTheme.lightTheme(context),
        initialRoute: ruta,
        routes: routes,
      );
    }
  }
}
