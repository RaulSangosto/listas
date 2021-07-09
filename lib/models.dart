import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class User {
  String? id;
  String nombre;
  String email;

  User({this.id, this.nombre = "", this.email = ""});

  static User fromJson(Map<String, dynamic> json) => User(
        nombre: json['nombre'],
        id: json['id'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };

  String getIniciales() {
    String iniciales = "";
    for (var s in this.nombre.split(" ")) {
      iniciales += s.substring(0, 1).toUpperCase();
    }

    if (iniciales.length > 2) {
      return iniciales.substring(0, 2);
    }
    return iniciales;
  }
}

class Categoria {
  String? id;
  String nombre;
  String? iconoUrl;

  Categoria({this.id, this.nombre = "", this.iconoUrl});

  static Categoria fromJson(Map<String, dynamic> json) => Categoria(
        nombre: json['nombre'],
        id: json['id'],
        iconoUrl: json['iconoUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'iconoUrl': iconoUrl,
      };
}

class Articulo {
  String? id;
  @required
  String nombre;
  Categoria? categoria;

  Articulo({this.id, this.nombre = "", this.categoria});

  static Articulo fromJson(Map<String, dynamic> json) => Articulo(
        nombre: json['nombre'],
        id: json['id'],
        categoria: json['categoria'] != null
            ? Categoria.fromJson(json['categoria'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'categoria': (categoria != null) ? categoria!.toJson() : "",
      };
}

class Item {
  String? id;
  Articulo? articulo;
  bool marcado;
  int cantidad;

  Item({this.id, this.articulo, this.marcado = false, this.cantidad = 1});

  static Item fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        marcado: json['marcado'],
        cantidad: json['cantidad'],
        articulo: Articulo.fromJson(json['articulo']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'marcado': marcado,
        'cantidad': cantidad,
        'articulo': (articulo != null) ? articulo!.toJson() : "",
      };

  marcar() {
    this.marcado = !this.marcado;
  }
}

class Lista {
  String id;
  String nombre;
  User? autor;
  RxList<Item> items;
  List<User> usuarios;

  Lista(
      {this.id = "",
      this.nombre = "",
      required this.autor,
      required this.items,
      required this.usuarios});

  int itemsCompletos() {
    int completos = 0;
    for (var item in this.items) {
      if (item.marcado) {
        completos++;
      }
    }

    return completos;
  }

  List<Map<String, dynamic>> getItems() {
    List<Map<String, dynamic>> lista = [];
    for (Item item in this.items) {
      lista.add(item.toJson());
    }
    return lista;
  }

  List<Map<String, dynamic>> getUsuarios() {
    List<Map<String, dynamic>> lista = [];
    for (User user in this.usuarios) {
      lista.add(user.toJson());
    }
    return lista;
  }

  bool hasItemArticulo(Articulo articulo) {
    return items
        .where((item) => (item.articulo!.nombre == articulo.nombre))
        .isNotEmpty;
  }

  void addItem(Item item) {
    items.add(item);
  }

  Item getItemArticulo(Articulo articulo) {
    return items
        .where((item) => (item.articulo!.nombre == articulo.nombre))
        .first;
  }

  void marcarItem(Item item) {
    item.marcar();
  }

  void increaseItem(Articulo articulo) {
    Item item = getItemArticulo(articulo);
    item.cantidad++;
  }

  void decreaseItem(Articulo articulo) {
    Item item = getItemArticulo(articulo);
    if (item.cantidad > 1) {
      item.cantidad--;
    } else {
      items.remove(item);
    }
  }

  static Lista fromJson(Map<String, dynamic> json) => Lista(
        autor: json['autor'],
        nombre: json['nombre'],
        id: json['id'],
        items: json['items'],
        usuarios: json['usuarios'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'autor': autor?.id,
        'items': getItems(),
        'usuarios': getUsuarios(),
      };
}
