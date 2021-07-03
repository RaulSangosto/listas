import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/articulos_controller.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/models.dart';
import 'package:listas/widgets/articulos.dart';

class ItemAddPage extends StatefulWidget {
  ItemAddPage({Key? key}) : super(key: key);

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void onAddItem(Articulo articulo) {
    final String lista_id = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(lista_id);
    var listas = ListaController.to.listas;
    int index = listas.indexOf(lista);

    // final provider = Provider.of<ListasProvider>(context, listen: false);

    if (lista.hasItemArticulo(articulo)) {
      lista.increaseItem(articulo);
    } else {
      Item item = new Item(articulo: articulo);
      lista.addItem(item);
    }
    listas.removeAt(index);
    lista.items.sort((a, b) => b.marcado ? -1 : 1);
    listas.insert(index, lista);

    // final provider = Provider.of<ListasProvider>(context, listen: false);
    // setState(() {
    //   provider.addItemLista(widget.lista.id!, item);
    // });
  }

  void onRemoveItem(Articulo articulo) {
    final String lista_id = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(lista_id);
    var listas = ListaController.to.listas;
    lista.decreaseItem(articulo);
    int index = listas.indexOf(lista);
    listas.removeAt(index);
    listas.insert(index, lista);
  }

  int getCantidadArticulo(Articulo articulo) {
    int cantidad = 0;
    final String lista_id = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(lista_id);

    if (lista.hasItemArticulo(articulo)) {
      cantidad = lista.getItemArticulo(articulo).cantidad;
    }
    return cantidad;
  }

  @override
  Widget build(BuildContext context) {
    final articulos = ArticuloController.to.articulos;

    return Hero(
      tag: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Añadir Item'),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Get.back() //Navigator.pop(context),
              ),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var articulo in articulos)
                  ArticuloListTile(
                    articulo: articulo,
                    onAddItem: onAddItem,
                    onRemoveItem: onRemoveItem,
                    cantidad: getCantidadArticulo(articulo),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
