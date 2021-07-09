import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/models.dart';

class ListaController extends GetxController {
  static ListaController get to => Get.find();

  List<Lista> _listas = [
    Lista(
      id: '1',
      nombre: 'Lista de la Compra 1',
      autor: new User(id: '1', nombre: 'raúl', email: 'raulsangosto@gmail.com'),
      items: ([
        new Item(
          id: '1',
          articulo: new Articulo(
            id: '1',
            nombre: 'salmón',
            categoria: new Categoria(id: '1', nombre: 'pescado'),
          ),
        ),
        new Item(
          id: '2',
          articulo: new Articulo(
              id: '2',
              nombre: 'jamón',
              categoria: new Categoria(id: '2', nombre: 'carne')),
          cantidad: 2,
          marcado: true,
        )
      ]).obs,
      usuarios: [
        new User(
            id: '2', nombre: 'marta sánchez angosto', email: 'marta@mail.es'),
        new User(id: '3', nombre: 'jose', email: 'jose@mail.es'),
      ],
    ),
    Lista(
      id: '2',
      nombre: 'Lista de la Compra 2',
      autor: new User(id: '1', nombre: 'raúl', email: 'raulsangosto@gmail.com'),
      items: ([
        new Item(
          id: '1',
          articulo: new Articulo(
            id: '1',
            nombre: 'salmón',
            categoria: new Categoria(id: '1', nombre: 'pescado'),
          ),
        ),
        new Item(
          id: '2',
          articulo: new Articulo(
              id: '2',
              nombre: 'jamón',
              categoria: new Categoria(id: '2', nombre: 'carne')),
          cantidad: 2,
          marcado: true,
        )
      ]).obs,
      usuarios: [
        new User(
            id: '2', nombre: 'marta sánchez angosto', email: 'marta@mail.es'),
        new User(id: '3', nombre: 'jose', email: 'jose@mail.es'),
      ],
    ),
  ];

  GlobalKey<AnimatedListState> _myListKey = GlobalKey<AnimatedListState>();

  List<Lista> get listas => _listas.toList();
  GlobalKey<AnimatedListState> get listKey => _myListKey;

  void addLista(Lista lista) {
    _listas.add(lista);

    update();
  }

  Lista getLista(String id) {
    return _listas.where((lista) => (lista.id == id)).first;
  }

  void addItemLista(String id, Item item) {
    Lista lista = getLista(id);
    lista.items.add(item);

    update();
  }

  void removeItemLista(String id, Articulo articulo) {
    Lista lista = getLista(id);
    Item item = lista.items
        .where((item) => (item.articulo?.nombre == articulo.nombre))
        .first;
    if (lista.items.contains(item)) {
      lista.items.remove(item);
    }

    update();
  }

  void marcarItemLista(String id, Item item) {
    Lista lista = getLista(id);
    lista.marcarItem(item);

    print("marcado: ${item.marcado}");
    update();
  }

  List<Categoria> _categorias = [
    Categoria(nombre: "Categoria 1"),
    Categoria(nombre: "Categoria 2"),
    Categoria(nombre: "Categoria 3"),
    Categoria(nombre: "Categoria 4"),
  ];

  List<Articulo> _articulos = [
    Articulo(nombre: "Lista Test 1"),
    Articulo(nombre: "Lista Test 2"),
    Articulo(nombre: "Lista Test 3"),
    Articulo(nombre: "Lista Test 4"),
  ];

  List<Articulo> get articulos => _articulos.toList();
  List<Categoria> get categorias => _categorias.toList();

  void addArticulo(Articulo articulo) {
    _articulos.add(articulo);

    update();
  }

  void addCategoria(Categoria categoria) {
    _categorias.add(categoria);

    update();
  }
}
