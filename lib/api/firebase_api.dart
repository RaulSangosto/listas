import 'package:cloud_firestore/cloud_firestore.dart';
import '../models.dart';

class FirebaseApi {
  static Future<String> createLista(Lista lista) async {
    final docLista = FirebaseFirestore.instance.collection('lista').doc();

    lista.id = docLista.id;

    await docLista.set(lista.toJson());
    return docLista.id;
  }
}
