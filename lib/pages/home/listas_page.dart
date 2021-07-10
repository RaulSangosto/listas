import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/articulos_controller.dart';
import 'package:listas/controller/listas_controller.dart';

class ListasPage extends StatefulWidget {
  @override
  _ListasPageState createState() => _ListasPageState();
}

class _ListasPageState extends State<ListasPage> {
  final ListaController listaController = Get.put(ListaController());
  final ArticuloController articuloController = Get.put(ArticuloController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var lista in listaController.listas)
              ListItem(
                listaId: lista.id,
              ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.listaId,
  }) : super(key: key);

  final String listaId;
  final tag = 1;

  @override
  Widget build(BuildContext context) {
    final lista = ListaController.to.getLista(listaId);
    return Card(
      elevation: 3,
      child: ListTile(
        // leading: Icon(Icons.album),
        // trailing: Icon(Icons.more_vert),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lista.nombre,
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        lista.itemsCompletos().toString() +
                            '/' +
                            lista.items.length.toString(),
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(children: [
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.green[200],
              ),
              FractionallySizedBox(
                widthFactor: lista.itemsCompletos() > 0
                    ? lista.itemsCompletos() / lista.items.length
                    : 0,
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.green,
                ),
              ),
            ])
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: lista.usuarios.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      radius: 10.0,
                      child: Text(
                        lista.usuarios.first.getIniciales(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(lista.usuarios.first.email),
                    SizedBox(
                      width: 10,
                    ),
                    buildMoreUsuarios(context),
                  ],
                )
              : SizedBox(),
        ),
        onTap: () {
          Get.toNamed("/lista/detalle/$listaId");
        },
      ),
    );
  }

  Widget buildMoreUsuarios(context) {
    final lista = ListaController.to.getLista(listaId);

    if (lista.usuarios.length > 1) {
      return CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        radius: 10.0,
        child: Text(
          '+' + (lista.usuarios.length - 1).toString(),
          style: TextStyle(fontSize: 10),
        ),
      );
    }
    return SizedBox();
  }
}
