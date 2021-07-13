import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/controller/theme_data.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: MyThemeData.bgColorDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Hero(
        tag: lista.id,
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
                      style: MyThemeData.h3,
                    ),
                    Row(
                      children: [
                        Text(
                          lista.itemsCompletos().toString() +
                              '/' +
                              lista.items.length.toString(),
                          style: MyThemeData.h3Primary,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: MyThemeData.highlightTextColorDark,
                        )
                      ],
                    )
                  ],
                ),
              ),
              LinearProgressIndicator(
                minHeight: 3,
                backgroundColor: MyThemeData.bgColorDark,
                color: MyThemeData.accentColor,
                value: lista.itemsCompletos() > 0
                    ? lista.itemsCompletos() / lista.items.length
                    : 0,
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: lista.usuarios.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: MyThemeData.highlightTextColorDark,
                        foregroundColor: MyThemeData.textColorLight,
                        radius: 10.0,
                        child: Text(
                          lista.usuarios.first.getIniciales(),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        lista.usuarios.first.email,
                        style: MyThemeData.defaultHighlightText,
                      ),
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
      ),
    );
  }

  Widget buildMoreUsuarios(context) {
    final lista = ListaController.to.getLista(listaId);

    if (lista.usuarios.length > 1) {
      return CircleAvatar(
        backgroundColor: MyThemeData.bgColorDark,
        foregroundColor: MyThemeData.primaryColor,
        radius: 10.0,
        child: Text(
          '+' + (lista.usuarios.length - 1).toString(),
          style: MyThemeData.smallPrimaryText,
        ),
      );
    }
    return SizedBox();
  }
}

class GridListaItem extends StatelessWidget {
  const GridListaItem({
    Key? key,
    required this.listaId,
  }) : super(key: key);

  final String listaId;
  final tag = 1;

  @override
  Widget build(BuildContext context) {
    final lista = ListaController.to.getLista(listaId);
    return Card(
      color: MyThemeData.bgColorDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Hero(
        tag: lista.id,
        child: ListTile(
          onTap: () {
            Get.toNamed("/lista/detalle/$listaId");
          },
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shopping_bag_rounded,
                          color: MyThemeData.primaryColor,
                          size: 30,
                        ),
                        CircularPercentIndicator(
                          backgroundColor: MyThemeData.primaryColor50,
                          progressColor: MyThemeData.primaryColor,
                          startAngle: 220,
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: lista.items.length > 0
                              ? lista.itemsCompletos() / lista.items.length
                              : 0,
                          center: new Text(
                            "${lista.items.length > 0 ? (lista.itemsCompletos() / lista.items.length * 100).floor().toString() : "0"}%",
                            style: MyThemeData.smallPrimaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      lista.nombre,
                      softWrap: true,
                      style: MyThemeData.h4,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            "${lista.itemsCompletos()} obtenido",
                            style: MyThemeData.smallPrimaryText,
                          ),
                          backgroundColor: MyThemeData.softPrimaryColor,
                        ),
                        Chip(
                          label: Text(
                            "${lista.items.length} total",
                            style: MyThemeData.smallPrimaryText,
                          ),
                          backgroundColor: MyThemeData.bgColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddGridListaItem extends StatelessWidget {
  const AddGridListaItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/lista/add");
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: DottedBorder(
          color: MyThemeData.primaryColor50,
          dashPattern: [8, 8],
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(25),
          child: Center(
            child: Text(
              "+ Añadir",
              softWrap: true,
              style: MyThemeData.h4,
            ),
          ),
        ),
      ),
    );
  }
}
