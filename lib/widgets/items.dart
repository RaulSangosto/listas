import 'package:flutter/material.dart';
import 'package:listas/models.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final int index;
  final Function onCheck;

  ItemListTile(
      {required this.item, required this.index, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.marcado ? Colors.transparent : Colors.white,
      elevation: item.marcado ? 0 : 1,
      child: ListTile(
        leading: IconButton(
          onPressed: () => onCheck(index),
          icon: item.marcado
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.articulo!.nombre),
              if (item.cantidad > 1 && !item.marcado)
                Text(item.cantidad.toString()),
            ],
          ),
        ),
        trailing: Icon(Icons.fastfood),
      ),
    );
  }
}

class BlankListTile extends StatelessWidget {
  const BlankListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
