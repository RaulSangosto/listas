import 'package:get/get.dart';
import 'package:listas/models.dart';

class ArticuloController extends GetxController {
  static ArticuloController get to => Get.find();

  final articulos = ([
    Articulo(id: "1", nombre: "Lista Test 1"),
    Articulo(id: "2", nombre: "Lista Test 2"),
    Articulo(id: "3", nombre: "Lista Test 3"),
    Articulo(id: "4", nombre: "Lista Test 4"),
  ]).obs;

  Articulo getArticulo(String id) {
    return articulos.where((articulo) => (articulo.id == id)).first;
  }

  Articulo getArticuloNombre(String nombre) {
    return articulos.where((articulo) => (articulo.nombre == nombre)).first;
  }
}
