import 'package:flutter/material.dart';
import 'package:listas/main.dart';
import 'package:listas/models.dart';
import 'package:listas/pages/lista/lista_detalle_page.dart';
import 'package:listas/provider/listas.dart';
import 'package:provider/provider.dart';

class ListasPage extends StatefulWidget {
  @override
  _ListasPageState createState() => _ListasPageState();
}

class _ListasPageState extends State<ListasPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListasProvider>(context);
    final listas = provider.listas;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var lista in listas)
            ListItem(
              lista_id: lista.id,
            ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.lista_id,
  }) : super(key: key);

  final String lista_id;
  final tag = 1;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListasProvider>(context);
    final lista = provider.getLista(lista_id);
    return Card(
      elevation: 3,
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
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        lista.items_completos().toString() +
                            '/' +
                            lista.items.length.toString(),
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(children: [
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.green[200],
              ),
              FractionallySizedBox(
                widthFactor: lista.items_completos() > 0
                    ? lista.items_completos() / lista.items.length
                    : 0,
                child: Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.green,
                ),
              ),
            ])
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: lista.usuarios.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      radius: 10.0,
                      child: Text(
                        lista.usuarios.first.get_iniciales(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(lista.usuarios.first.email),
                    SizedBox(
                      width: 10,
                    ),
                    buildMoreUsuarios(context),
                  ],
                )
              : SizedBox(),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            ListaDetallePage.routeName,
            arguments: ScreenListaArguments(lista_id, tag),
          );
        },
        // subtitle: Text('Participantes'),
      ),
    );
  }

  Widget buildMoreUsuarios(context) {
    final provider = Provider.of<ListasProvider>(context);
    final lista = provider.getLista(lista_id);

    if (lista.usuarios.length > 1) {
      return CircleAvatar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        radius: 10.0,
        child: Text(
          '+' + (lista.usuarios.length - 1).toString(),
          style: TextStyle(fontSize: 10),
        ),
      );
    }
    return SizedBox();
  }
}
