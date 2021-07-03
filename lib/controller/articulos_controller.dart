import 'package:get/get.dart';
import 'package:listas/models.dart';

class ArticuloController extends GetxController {
  static ArticuloController get to => Get.find();

  final _articulos = ([
    Articulo(id: "1", nombre: "Lista Test 1"),
    Articulo(id: "2", nombre: "Lista Test 2"),
    Articulo(id: "3", nombre: "Lista Test 3"),
    Articulo(id: "4", nombre: "Lista Test 4"),
  ]).obs;

  List<Articulo> get articulos => _articulos.toList();

  Articulo getArticulo(String id) {
    return _articulos.where((articulo) => (articulo.id == id)).first;
  }
}
