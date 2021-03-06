import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/articulos_controller.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/controller/theme_data.dart';
import 'package:listas/models.dart';
import 'package:listas/widgets/articulos.dart';
import 'package:listas/widgets/items.dart';

class ItemAddPage extends StatefulWidget {
  ItemAddPage({Key? key}) : super(key: key);

  @override
  _ItemAddPageState createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  void onAddItem(Articulo articulo) {
    final String listaId = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(listaId);
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    if (lista.hasItemArticulo(articulo)) {
      lista.increaseItem(articulo);
    } else {
      Item item = new Item(articulo: articulo);
      lista.addItem(item);
      _myListKey.currentState!.insertItem(
        0,
        duration: Duration(milliseconds: 600),
      );
    }
  }

  void onRemoveItem(Articulo articulo) {
    final String listaId = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(listaId);
    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;
    Item item = lista.getItemArticulo(articulo);
    if (item.cantidad <= 1) {
      int index = lista.items.indexOf(item);
      _myListKey.currentState!
          .removeItem(index, (context, animation) => BlankListTile());
    }
    lista.decreaseItem(articulo);
  }

  int getCantidadArticulo(Articulo articulo) {
    final articulos = ArticuloController.to.articulos;
    int cantidad = 0;

    final String listaId = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(listaId);

    if (lista.hasItemArticulo(articulo)) {
      cantidad = lista.getItemArticulo(articulo).cantidad;
    }
    int index = articulos.indexOf(articulo);
    articulos.removeAt(index);
    articulos.insert(index, articulo);
    return cantidad;
  }

  void onChangedNombre(String nombre) {}

  @override
  Widget build(BuildContext context) {
    final articulos = ArticuloController.to.articulos;

    return Hero(
      tag: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: buildTitle(),
          // leading: IconButton(
          //     color: Colors.blue,
          //     icon: Icon(Icons.close),
          //     onPressed: () => Get.back() //Navigator.pop(context),
          //     ),
          // actions: [
          //   IconButton(
          //     color: Colors.blue,
          //     icon: Icon(Icons.mic),
          //     onPressed: () {},
          //   )
          // ],
          elevation: 0,
          // backgroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlankListTile(),
                for (var articulo in articulos)
                  ArticuloListTile(
                    articulo: articulo,
                    onAddItem: onAddItem,
                    onRemoveItem: onRemoveItem,
                    cantidad: getCantidadArticulo(articulo),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => Expanded(
        child: TextFormField(
          maxLines: 1,
          onChanged: onChangedNombre,
          autofocus: true,
          validator: (title) {
            if (title!.isEmpty) {
              return 'El titulo no puede estar vacio';
            }
            return null;
          },
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                color: Colors.blue,
                icon: Icon(Icons.mic),
                onPressed: () {},
              ),
              prefixIcon: IconButton(
                color: Colors.blue,
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
              border: InputBorder.none,
              // labelText: 'Titulo',
              hintText: 'A??adir art??culo'),
        ),
      );
}

class ArticulosSearch extends SearchDelegate<Articulo?> {
  ArticulosSearch({required this.listaId});

  final List<Articulo> _data = ArticuloController.to.articulos;
  final List<Articulo> _history = ArticuloController.to.articulos;
  final String listaId;

  void onAddItem(Articulo articulo) {
    Lista lista = ListaController.to.getLista(listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;

    if (lista.hasItemArticulo(articulo)) {
      lista.increaseItem(articulo);
    } else {
      Item item = new Item(articulo: articulo);
      lista.addItem(item);
      _myListKey.currentState!.insertItem(
        0,
        duration: Duration(milliseconds: 600),
      );
    }

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  void onRemoveItem(Articulo articulo) {
    Lista lista = ListaController.to.getLista(listaId);
    var listas = ListaController.to.listas;
    int listaPos = listas.indexOf(lista);

    GlobalKey<AnimatedListState> _myListKey = ListaController.to.listKey;
    Item item = lista.getItemArticulo(articulo);
    if (item.cantidad <= 1) {
      int index = lista.items.indexOf(item);
      _myListKey.currentState!
          .removeItem(index, (context, animation) => BlankListTile());
    }
    lista.decreaseItem(articulo);

    listas.remove(lista);
    listas.insert(listaPos, lista);
  }

  int getCantidadArticulo(Articulo articulo) {
    final articulos = ArticuloController.to.articulos;
    int cantidad = 0;

    final String listaId = Get.parameters["id"]!;
    Lista lista = ListaController.to.getLista(listaId);

    if (lista.hasItemArticulo(articulo)) {
      cantidad = lista.getItemArticulo(articulo).cantidad;
    }
    int index = articulos.indexOf(articulo);
    articulos.removeAt(index);
    articulos.insert(index, articulo);
    return cantidad;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme:
            theme.primaryIconTheme.copyWith(color: MyThemeData.primaryColor),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<Articulo> suggestions = query.isEmpty
        ? _history
        : _data.where((Articulo a) =>
            a.nombre.toLowerCase().startsWith(query.toLowerCase()));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.map<Articulo>((Articulo i) => i).toList(),
      onAdd: (Articulo suggestion) {
        query = "";
        _history.remove(suggestion);
        onAddItem(suggestion);
        _history.insert(0, suggestion);
        //showResults(context);
      },
      onRemove: (Articulo suggestion) {
        query = "";
        onRemoveItem(suggestion);
        //showResults(context);
      },
      getCantidad: getCantidadArticulo,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Articulo searched = ArticuloController.to.getArticuloNombre(query);
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        ArticuloListTile(
          articulo: searched,
          cantidad: getCantidadArticulo(searched),
          onAddItem: (Articulo suggestion) {
            query = "";
            onAddItem(suggestion);
            //showResults(context);
          },
          onRemoveItem: (Articulo suggestion) {
            query = "";
            onRemoveItem(suggestion);
            //showResults(context);
          },
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Voice Search',
        icon: const Icon(Icons.mic),
        onPressed: () {
          query = 'TODO: implement voice input';
        },
      )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions,
      required this.query,
      required this.onAdd,
      required this.onRemove,
      required this.getCantidad});

  final List<Articulo> suggestions;
  final String query;
  final ValueChanged<Articulo> onAdd;
  final ValueChanged<Articulo> onRemove;
  final Function getCantidad;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Articulo? newArticulo =
        query.isEmpty ? null : Articulo(nombre: query);
    final bool isNew = newArticulo == null
        ? false
        : suggestions
            .where((articulo) => (articulo.nombre == newArticulo.nombre))
            .isEmpty;

    return ListView.builder(
      itemCount: !isNew ? suggestions.length : suggestions.length + 1,
      itemBuilder: (BuildContext context, int i) {
        if (isNew) {
          if (i == 0) {
            return ArticuloListTile(
              articulo: newArticulo,
              cantidad: 0,
              onAddItem: (Articulo suggestion) {
                print(suggestion.nombre);
                suggestion.id =
                    DateTime.now().microsecondsSinceEpoch.toString();
                print(
                    "length articulos before: ${ArticuloController.to.articulos.length}");
                ArticuloController.to.articulos.insert(0, suggestion);
                onAdd(suggestion);
                print(
                    "length articulos after: ${ArticuloController.to.articulos.length}");
                //showResults(context);
              },
              onRemoveItem: onRemove,
            );
          } else {
            final Articulo suggestion = suggestions[i - 1];
            return ArticuloListTile(
              articulo: suggestion,
              cantidad: getCantidad(suggestion),
              onAddItem: onAdd,
              onRemoveItem: onRemove,
            );
          }
        } else {
          final Articulo suggestion = suggestions[i];
          return ArticuloListTile(
            articulo: suggestion,
            cantidad: getCantidad(suggestion),
            onAddItem: onAdd,
            onRemoveItem: onRemove,
          );
        }
      },
    );
  }
}
