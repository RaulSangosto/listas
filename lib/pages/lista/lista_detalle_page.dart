import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/controller/theme_data.dart';
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
    Lista lista = ListaController.to.getLista(listaId);

    return Scaffold(
      backgroundColor: MyThemeData.primaryColor,
      body: Body(listaId: listaId),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(lista.nombre),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyThemeData.primaryColor,
        onPressed: () {
          showSearch(
              context: context, delegate: ArticulosSearch(listaId: listaId));
          //Get.toNamed("/lista/$listaId/add-item");
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        heroTag: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
  void removeItem(int index) {
    Lista lista = ListaController.to.getLista(widget.listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    _myListKey.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
            sizeFactor: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(0, 0.5),
              ),
            ),
            child: BlankListTile()));

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  void addItem(int index) {
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

    removeItem(index);
    Item item = lista.items.removeAt(index);

    if (!item.marcado) {
      index = lista.items.length;
    } else {
      index = 0;
    }
    lista.items.insert(index, item);
    lista.marcarItem(item);
    addItem(index);

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;
    Lista lista = ListaController.to.getLista(widget.listaId);

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
              child: Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      child: (lista.items.length > 0 &&
                              lista.itemsCompletos() >= lista.items.length)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      for (var i = 0;
                                          i < lista.items.length;
                                          i++) {
                                        removeItem(i);
                                        //lista.removeItemAt(i);
                                      }
                                      //lista.clearItems();
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      side:
                                          MaterialStateProperty.all<BorderSide>(
                                              BorderSide(
                                                  color:
                                                      MyThemeData.primaryColor,
                                                  width: 2)),
                                      elevation:
                                          MaterialStateProperty.all<double>(0),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              MyThemeData.primaryColor),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("Vaciar Lista"),
                                        SizedBox(width: 5),
                                        Icon(Icons.delete_outline),
                                      ],
                                    ))
                              ],
                            )
                          : SizedBox.shrink(),
                    ),
                    Expanded(
                      child: Scrollbar(
                        thickness: 5,
                        isAlwaysShown: true,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: AnimatedList(
                            key: _myListKey,
                            initialItemCount: lista.items.length + 1,
                            itemBuilder: (BuildContext context, int i,
                                Animation<double> animation) {
                              if (i >= lista.items.length) {
                                return AddListTile(
                                  listaId: lista.id,
                                );
                              } else {
                                return SizeTransition(
                                  sizeFactor: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Interval(0.2, 1),
                                    ),
                                  ),
                                  child: ItemListTile(
                                    item: lista.items[i],
                                    index: i,
                                    onCheck: onCheck,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSliverList(Lista lista, Function onCheck) {
    var listas = ListaController.to.listas;
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    int index = listas.indexOf(lista);
    return Obx(
      () => Column(
        children: [
          LinearProgressIndicator(
            backgroundColor: MyThemeData.primaryColor50,
            color: MyThemeData.primaryColor,
            value: lista.items.length > 0
                ? (lista.itemsCompletos() / lista.items.length)
                : 0.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: (lista.items.length > 0 &&
                    lista.itemsCompletos() >= lista.items.length)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  MyThemeData.textColorDark),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyThemeData.primaryColor)),
                          child: Row(
                            children: [
                              Text("Vaciar Lista"),
                              SizedBox(width: 5),
                              Icon(Icons.delete_outline),
                            ],
                          ))
                    ],
                  )
                : SizedBox.shrink(),
          ),
          Expanded(
            child: AnimatedList(
              key: _myListKey,
              initialItemCount: lista.items.length,
              itemBuilder:
                  (BuildContext context, int i, Animation<double> animation) {
                return SizeTransition(
                  sizeFactor: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(0.2, 1),
                    ),
                  ),
                  child: ItemListTile(
                    item: lista.items[i],
                    index: i,
                    onCheck: onCheck,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
      // backgroundColor: Colors.white,
      expandedHeight: 120.0,
      floating: false,
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
              style: MyThemeData.h3Light,
            )),
      ),
    );
  }
}
