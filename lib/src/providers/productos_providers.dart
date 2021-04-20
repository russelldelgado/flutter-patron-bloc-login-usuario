import 'dart:convert';

import 'package:formvalidation/src/models/producto_models.dart';
import 'package:http/http.dart' as http;

class ProductosProviders{
  final String _url = "flutter-varios-77c4e-default-rtdb.firebaseio.com";


  Future<bool> crearProducto(ProductoModels producto)async{
//esta es la ruta que quiero poner para insertar nuevos registros a mi bbdd
    final url = Uri.https(_url, "productos.json");
//con esto lo que hago es mandar a mi bbdd los productos en forma de string que es lo que me pide mi bbdd. esto me da una respuesta con el id de mi producto;
   final response = await http.post(url ,body: productoModelsToJson(producto));
//
   final decodedData = jsonDecode(response.body);

   print(decodedData);

    return true;
  }


}