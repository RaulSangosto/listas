import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/models.dart';
import 'package:listas/pages/item/item_add_page.dart';
import 'package:listas/widgets/items.dart';

// class ListaDetallePage extends StatefulWidget {
//   final Lista lista;
//   final int tag;

//   ListaDetallePage({Key key, @required this.lista, this.tag}) : super(key: key);

//   @override
//   _ListaDetallePageState createState() => _ListaDetallePageState();
// }

class ListaDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String listaId = Get.parameters["id"]!;

    return Scaffold(
      body: Body(listaId: listaId),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showSearch(
              context: context, delegate: ArticulosSearch(listaId: listaId));
          //Get.toNamed("/lista/$listaId/add-item");
        },
        child: Icon(Icons.add),
        heroTag: 1,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final String listaId;

  const Body({Key? key, required this.listaId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void removeItem(Item item, int index) {
    Lista lista = ListaController.to.getLista(widget.listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    _myListKey.currentState!.removeItem(
        index,
        (context, animation) => (index == 0 && !item.marcado)
            ? ItemListTile(
                item: item,
                index: index,
                onCheck: onCheck,
              )
            : BlankListTile());

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  void addItem(Item item, int index) {
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;
    Lista lista = ListaController.to.getLista(widget.listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    _myListKey.currentState!.insertItem(
      index,
      duration: Duration(milliseconds: 400),
    );

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  void onCheck(int index) {
    Lista lista = ListaController.to.getLista(widget.listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    Item item = lista.items.removeAt(index);
    removeItem(item, index);
    if (!item.marcado) {
      index = lista.items.length;
    } else {
      index = 0;
    }
    lista.items.insert(index, item);
    lista.marcarItem(item);
    addItem(item, index);

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  @override
  Widget build(BuildContext context) {
    Lista lista = ListaController.to.getLista(widget.listaId);

    return CustomScrollView(
      slivers: <Widget>[
        SliverMultilineAppBar(
          title: lista.nombre,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_basket_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.people_alt_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        SliverFillRemaining(child: buildSliverList(lista, onCheck)),
      ],
    );
  }

  Widget buildSliverList(Lista lista, Function onCheck) {
    var listas = ListaController.to.listas;
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    int index = listas.indexOf(lista);
    return Obx(() => AnimatedList(
          key: _myListKey,
          initialItemCount: lista.items.length,
          itemBuilder:
              (BuildContext context, int i, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: Offset(
                          0,
                          (i >= lista.items.length
                              ? 0
                              : (lista.items[i].marcado ? -1 : 1))),
                      end: Offset.zero)
                  .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0, 0.5),
                ),
              ),
              child: ItemListTile(
                item: lista.items[i],
                index: i,
                onCheck: onCheck,
              ),
            );
          },
        ));
  }

  // Widget buildSliverList(Lista lista, Function onCheck) {
  //   var listas = ListaController.to.listas;
  //   int index = listas.indexOf(lista);
  //   if (lista.items.isNotEmpty) {
  //     return Obx(() => ListView(
  //           children: [
  //             for (var item in listas[index].items)
  //               ItemListTile(item: item, onCheck: onCheck)
  //           ],
  //         ));
  //   } else {
  //     return Center(
  //       child: Text('Comienza añadiendo productos, es muy fácil'),
  //     );
  //   }
  // }
}

class SliverMultilineAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;

  SliverMultilineAppBar(
      {this.title = "",
      this.leading = const Text(""),
      this.actions = const []});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    double availableWidth = mediaQuery.size.width;
    if (actions.isNotEmpty) {
      availableWidth -= 32 * actions.length;
    }
    availableWidth -= 32;
    // if (leading != null) {
    //   availableWidth -= 32;
    // }

    return SliverAppBar(
      expandedHeight: 120.0,
      floating: true,
      pinned: true,
      leading: leading,
      actions: actions,
      elevation: 4,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: availableWidth,
          ),
          child: Text(
            title,
            textScaleFactor: .8,
          ),
        ),
      ),
    );
  }
}
