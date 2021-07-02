import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/main.dart';
import 'package:listas/models.dart';
import 'package:listas/pages/item/item_add_page.dart';
import 'package:listas/provider/listas.dart';
import 'package:listas/widgets/items.dart';
import 'package:provider/provider.dart';

// class ListaDetallePage extends StatefulWidget {
//   final Lista lista;
//   final int tag;

//   ListaDetallePage({Key key, @required this.lista, this.tag}) : super(key: key);

//   @override
//   _ListaDetallePageState createState() => _ListaDetallePageState();
// }

class ListaDetallePage extends StatefulWidget {
  @override
  State<ListaDetallePage> createState() => _ListaDetallePageState();
}

class _ListaDetallePageState extends State<ListaDetallePage> {
  void onCheck(Item item) {
    String lista_id = Get.parameters['id']!;
    final provider = Provider.of<ListasProvider>(context, listen: false);
    // setState(() {
    //   Lista lista = provider.getLista(lista_id);
    //   lista.marcarItem(item);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final String lista_id = Get.parameters["id"]!;

    return Scaffold(
      body: Body(lista_id: lista_id, onCheck: onCheck),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.toNamed("/lista/$lista_id/add-item");
          // Navigator.pushNamed(context, ItemAddPage.routeName,
          //     arguments: ScreenListaArguments(args.lista_id, args.tag));
        },
        child: Icon(Icons.add),
        heroTag: 1,
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.lista_id,
    required this.onCheck,
  }) : super(key: key);

  final String lista_id;
  final Function onCheck;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListasProvider>(context, listen: false);
    Lista lista = provider.getLista(lista_id);
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
        lista.items != null && lista.items.isNotEmpty
            ? SliverList(
                delegate: SliverChildListDelegate(
                  [
                    for (var item in lista.items)
                      ItemListTile(item: item, onCheck: onCheck)
                  ],
                ),
              )
            : SliverFillRemaining(
                child: Center(
                child: Text('Comienza añadiendo productos, es muy fácil'),
              )),
      ],
    );
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
    if (actions != null) {
      availableWidth -= 32 * actions.length;
    }
    if (leading != null) {
      availableWidth -= 32;
    }
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
