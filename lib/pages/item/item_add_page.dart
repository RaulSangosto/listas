import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/main.dart';
import 'package:listas/models.dart';
import 'package:listas/provider/listas.dart';
import 'package:listas/widgets/articulos.dart';
import 'package:provider/provider.dart';

class ItemAddPage extends StatefulWidget {
  ItemAddPage({Key? key}) : super(key: key);

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void onAddItem(Articulo articulo) {
    setState(() {
      final String lista_id = Get.parameters["id"]!;
      final provider = Provider.of<ListasProvider>(context, listen: false);
      Lista lista = provider.getLista(lista_id);

      if (lista.hasItemArticulo(articulo)) {
        lista.increaseItem(articulo);
      } else {
        Item item = new Item(articulo: articulo);
        lista.addItem(item);
      }
    });

    // final provider = Provider.of<ListasProvider>(context, listen: false);
    // setState(() {
    //   provider.addItemLista(widget.lista.id!, item);
    // });
  }

  void onRemoveItem(Articulo articulo) {
    setState(() {
      final String lista_id = Get.parameters["id"]!;
      final provider = Provider.of<ListasProvider>(context, listen: false);
      Lista lista = provider.getLista(lista_id);
      lista.decreaseItem(articulo);
    });
  }

  int getCantidadArticulo(Articulo articulo) {
    int cantidad = 0;
    final String lista_id = Get.parameters["id"]!;
    final provider = Provider.of<ListasProvider>(context, listen: false);
    Lista lista = provider.getLista(lista_id);

    if (lista.hasItemArticulo(articulo)) {
      cantidad = lista.getItemArticulo(articulo).cantidad;
    }
    return cantidad;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListasProvider>(context);
    final articulos = provider.articulos;

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
          child: Column(
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
    );
  }
}
