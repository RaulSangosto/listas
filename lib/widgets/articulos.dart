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
    return Flexible(
      child: ListTile(
        tileColor: Colors.white,
        leading: IconButton(
            onPressed: () => onAddItem(articulo),
            icon: Icon(
              Icons.add_circle,
              color: (cantidad == 0) ? Colors.grey : Colors.blue,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(articulo.nombre)),
            Expanded(child: Text(cantidad <= 0 ? " " : cantidad.toString())),
            SizedBox(width: 20),
          ],
        ),
        trailing: cantidad > 0
            ? IconButton(
                onPressed: () => onRemoveItem(articulo),
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            : SizedBox(
                width: 50,
              ),
      ),
    );
  }
}
