import 'package:flutter/material.dart';
import 'package:listas/controller/theme_data.dart';
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
              color: (cantidad == 0)
                  ? MyThemeData.primaryColor50
                  : MyThemeData.primaryColor,
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
                  (cantidad > 1 ? Icons.remove : Icons.close),
                  color: MyThemeData.dangerColor,
                ),
              )
            : SizedBox(
                width: 50,
              ),
      ),
    );
  }
}
