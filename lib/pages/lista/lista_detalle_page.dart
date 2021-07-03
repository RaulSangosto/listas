import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/models.dart';
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
    final String lista_id = Get.parameters["id"]!;

    return Scaffold(
      body: Body(lista_id: lista_id),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.toNamed("/lista/$lista_id/add-item");
        },
        child: Icon(Icons.add),
        heroTag: 1,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final String lista_id;

  const Body({Key? key, required this.lista_id}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void onCheck(Item item) {
    setState(() {
      Lista lista = ListaController.to.getLista(widget.lista_id);
      var listas = ListaController.to.listas;
      lista = ListaController.to.getLista(widget.lista_id);
      int index = listas.indexOf(lista);
      lista.marcarItem(item);
      listas.removeAt(index);
      lista.items.sort((a, b) => b.marcado ? -1 : 1);
      listas.insert(index, lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    Lista lista = ListaController.to.getLista(widget.lista_id);
    final _myListKey = GlobalKey<AnimatedListState>();

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
        buildSliverList(lista, onCheck),
      ],
    );
  }

  Widget buildSliverList(Lista lista, Function onCheck) {
    if (lista.items.isNotEmpty) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            for (var item in lista.items)
              ItemListTile(item: item, onCheck: onCheck)
          ],
        ),
      );
    } else {
      return SliverFillRemaining(
        child: Center(
          child: Text('Comienza añadiendo productos, es muy fácil'),
        ),
      );
    }
  }
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
