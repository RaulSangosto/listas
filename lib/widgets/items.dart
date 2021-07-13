import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/theme_data.dart';
import 'package:listas/models.dart';
import 'package:listas/pages/item/item_add_page.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final int index;
  final Function onCheck;

  ItemListTile(
      {required this.item, required this.index, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // if you need this
        side: BorderSide.none,
      ),
      color: item.marcado ? Colors.transparent : MyThemeData.bgColorDark,
      elevation: 0,
      child: ListTile(
        leading: Checkbox(
          checkColor: MyThemeData.textColorLight,
          activeColor: MyThemeData.primaryColor,
          shape: CircleBorder(side: BorderSide.none),
          splashRadius: 30,
          value: item.marcado,
          onChanged: (bool) {
            onCheck(index);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.articulo!.nombre,
                style: MyThemeData.defaultText,
              ),
              if (item.cantidad > 1 && !item.marcado)
                Text(item.cantidad.toString(), style: MyThemeData.defaultText),
            ],
          ),
        ),
        trailing: Icon(
          Icons.fastfood,
          color: item.marcado
              ? MyThemeData.primaryColor50
              : MyThemeData.primaryColor,
        ),
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

class AddListTile extends StatelessWidget {
  final String listaId;

  AddListTile({required this.listaId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: DottedBorder(
          color: MyThemeData.primaryColor50,
          dashPattern: [8, 8],
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "+ Añadir",
                      softWrap: true,
                      style: MyThemeData.h4,
                    ),
                  ]),
            ),
            onTap: () {
              showSearch(
                  context: context,
                  delegate: ArticulosSearch(listaId: listaId));
            },
          ),
        ),
      ),
    );
  }
}
