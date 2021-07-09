import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/pages/home/home_page.dart';
import 'package:listas/pages/item/item_add_page.dart';
import 'package:listas/pages/lista/lista_add_page.dart';
import 'package:listas/pages/lista/lista_detalle_page.dart';
import 'package:listas/pages/unknown.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class ScreenListaArguments {
  final String listaId;
  final int tag;

  ScreenListaArguments(this.listaId, this.tag);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final String title = 'Listas App';
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownPage()),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/lista/add', page: () => ListaAddPage()),
        GetPage(name: '/lista/detalle/:id', page: () => ListaDetallePage()),
        GetPage(name: '/lista/:id/add-item', page: () => ItemAddPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
      home: HomePage(),
      // home: FutureBuilder(
      //   future: _fbApp,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       print('You have an error! ${snapshot.error.toString()}');
      //       return Text('Algo ha ido mal!');
      //     } else if (snapshot.hasData) {
      //       return new HomePage();
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // )
      //HomePage(),
    );
  }
}
