import 'package:flutter/material.dart';
import 'package:listas/models.dart';

class ArticuloListTile extends StatelessWidget {
  final Articulo articulo;
  final int cantidad;
  final Function onAddItem;
  final Function onRemoveItem;

  ArticuloListTile(
      {required this.articulo,
      required this.cantidad,
      required this.onAddItem,
      required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        tileColor: Colors.white,
        leading: IconButton(
            onPressed: () => onAddItem(articulo),
            icon: Icon(
              Icons.add_circle,
              color: (cantidad == 0) ? Colors.grey : Colors.blue,
            )),
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(articulo.nombre),
              Text(cantidad.toString()),
            ],
          ),
        ),
        trailing: cantidad > 0
            ? IconButton(
                onPressed: () => onRemoveItem(articulo),
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
