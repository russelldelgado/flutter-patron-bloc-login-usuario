import 'dart:convert';

import 'package:formvalidation/src/models/producto_models.dart';
import 'package:mime_type/mime_type.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // este paquete lo importamos para el mimetype
import 'dart:io';

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

  Future<bool> editarProducto(ProductoModels producto)async{
//esta es la ruta que quiero poner para insertar nuevos registros a mi bbdd
    final url = Uri.https(_url, "productos/${ producto.id }.json");
//con esto lo que hago es mandar a mi bbdd los productos en forma de string que es lo que me pide mi bbdd. esto me da una respuesta con el id de mi producto;
   final response = await http.put(url ,body: productoModelsToJson(producto));
//
   final decodedData = jsonDecode(response.body);

   print(decodedData);

    return true;
  }

  Future<List<ProductoModels>> cargarProductos()async {
    final url = Uri.https(_url, "productos.json");
    final response = await http.get(url);

    final Map<String ,dynamic> decodedData = jsonDecode(response.body);
    final List<ProductoModels> productos = [];

    if(decodedData == null) return [];
    decodedData.forEach((key, value) { 
      final prodTemp = ProductoModels.fromJson(value);
      prodTemp.id = key;
      productos.add(prodTemp);
    });
  print(productos);
    return productos;

  }

  Future<bool> eliminarRegistro(String id)async{
    
    final url = Uri.https(_url, "productos/$id.json");
    final response = await http.delete(url);

    print(json.decode(response.body));

    return true;

  }


  Future<String> subirImagen(File imagen) async{

    //esto me pide un URI SI O SI.
    //esta url es la que me pide claudinary para poder subir imagenes al servidor si o si.
    final url = Uri.parse("https://api.cloudinary.com/v1_1/jhoel/image/upload?upload_preset=hhrdjdnh");
    //otra cosa que tengo que saber de la imagen es la terminacion , png , jpg , gif .... para esto usamos el paquete de mime_type
    final mimeType = mime(imagen.path).split("/");//necesito pasarle el path de donde se encuentra mi imagen y le hago un split para separarlo en un array por /

    //ahora nos creamos el request para poder abjuntarle lo que es la imagen.
    
    final imageUploadRequest = http.MultipartRequest("POST" , url);

    //ahora preparo mi archivo para adjuntarlo a este uploadrequest 
    //esto me pide dos parametro el primero es el file  que es lo que iria en el formulario como form data
    //y luego colocamos la ruta de donde se encuentra la imagen
    //adicionalmente tengo que especificar el mimetype , para esto importamos la libreria de http_parser y usamos su metodo 
    //el mediatype al cual pasamos dos parametros que hemos almacenado antes en mimetype
    //por lo que dice fernando herrera uno sera la imagen 0 , y el otro el subtipo 1
    
    final file = await http.MultipartFile.fromPath("file", imagen.path ,contentType: MediaType(mimeType[0] , mimeType[1]));
    
    //una vez tenga mi archivo lo tengo que adjuntar literalmente a mi upload request 
    //si quisieramos adjuntar muchos mas archivos solo tenemos que copier y pegar debajo lo mismo ima...files.add(fichero)
    imageUploadRequest.files.add(file);

  //con esto ejecutamos nuestra subida del archivo y nos devuelve un streamResponse porque asi funciona este archivo.
    final  streamResponse  = await imageUploadRequest.send();
    //ahora tendremos que obtener nuestra verdadera respuesta del streamResponse.
    final response =await http.Response.fromStream(streamResponse);

    //ahora comprobamos que todo salio bien por eso hacemos las comprobaciones de que si no los status codesno corresponden con el 200 o 201 nos devuelva un mensaje de error
    if (response.statusCode != 200 && response.statusCode != 201){
      print("ALGO SALIO MAL");
      return null;
    }

    final responseData = jsonDecode(response.body);
print(responseData);
    return responseData['secure_url'];

  }


}


//url para subir imagenes al servidor 
//https://api.cloudinary.com/v1_1/jhoel/image/upload?upload_preset=hhrdjdnh