import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/articulos_controller.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/controller/theme_data.dart';
import 'package:listas/widgets/listas.dart';

class ListasPage extends StatefulWidget {
  @override
  _ListasPageState createState() => _ListasPageState();
}

class _ListasPageState extends State<ListasPage> {
  final ListaController listaController = Get.put(ListaController());
  final ArticuloController articuloController = Get.put(ArticuloController());

  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Obx(
  //       () => Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           SizedBox(height: 15),
  //           for (var lista in listaController.listas)
  //             ListItem(
  //               listaId: lista.id,
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var listas = listaController.listas;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            color: MyThemeData.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(
                "Esto es un Banner",
                style: MyThemeData.lightText,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 7),
                itemCount: listas.length + 1,
                itemBuilder: (BuildContext ctx, index) {
                  if (index >= listas.length) {
                    return AddGridListaItem();
                  } else {
                    return GridListaItem(
                      listaId: listas[index].id,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
