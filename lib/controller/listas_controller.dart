import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/models.dart';

class ListaController extends GetxController {
  static ListaController get to => Get.find();

  final listas = ([
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
  ]).obs;

  final listKey = GlobalKey<AnimatedListState>();

  Lista getLista(String id) {
    return listas.where((lista) => (lista.id == id)).first;
  }
}
