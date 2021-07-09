import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/listas_controller.dart';
import 'package:listas/models.dart';

class ListaAddPage extends StatefulWidget {
  final int tag;

  ListaAddPage({Key? key, this.tag = 1}) : super(key: key);

  @override
  _ListaAddPageState createState() => _ListaAddPageState();
}

class _ListaAddPageState extends State<ListaAddPage> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Hero(
        tag: widget.tag,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.blue,
          ),
          backgroundColor: Colors.blue,
          body: Body(
            onChangedNombre: (nombre) => setState(() => this.nombre = nombre),
            onSavedLista: addLista,
          ),
        ),
      ),
    );
  }

  void addLista() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final lista = Lista(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nombre: nombre,
        autor: new User(nombre: 'raul'),
        items: new RxList<Item>([]),
        usuarios: [],
      );
      ListaController listaController = ListaController.to;
      listaController.listas.add(lista);

      Get.offNamed("/lista/detalle/${lista.id}");
    }
  }
}

class Body extends StatelessWidget {
  final String nombre;
  final ValueChanged<String> onChangedNombre;
  final VoidCallback onSavedLista;

  const Body({
    Key? key,
    this.nombre = '',
    required this.onChangedNombre,
    required this.onSavedLista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTitle(),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: nombre,
        onChanged: onChangedNombre,
        autofocus: true,
        validator: (title) {
          if (title!.isEmpty) {
            return 'El titulo no puede estar vacio';
          }
          return null;
        },
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            // labelText: 'Titulo',
            hintText: 'Nueva lista'),
      );

  Widget buildButton() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onSavedLista,
            child: Text(
              'CREAR',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      );
}
