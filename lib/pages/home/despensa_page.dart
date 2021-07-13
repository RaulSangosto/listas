import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/articulos_controller.dart';
import 'package:listas/widgets/articulos.dart';

class DespensaPage extends StatelessWidget {
  const DespensaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var articulos = ArticuloController.to.articulos;
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var articulo in articulos)
              ArticuloListTile(
                articulo: articulo,
                cantidad: 0,
                onAddItem: () {},
                onRemoveItem: () {},
              ),
          ],
        ),
      ),
    );
  }
}
