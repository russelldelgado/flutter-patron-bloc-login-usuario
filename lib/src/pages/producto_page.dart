
import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_models.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class ProductoPage extends StatefulWidget {


  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
final formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();
 final productoProvider = new ProductosProviders();

ProductoModels productoModels = ProductoModels();
bool _guardando = false;

File foto;

  @override
  Widget build(BuildContext context) {

    final ProductoModels prodData = ModalRoute.of(context).settings.arguments;

    if(prodData != null){
        productoModels = prodData;
    }

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(title: Text("Producto"),
       actions: [
         IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: _seleccionarFoto,),
         IconButton(icon: Icon(Icons.camera_alt), onPressed:_tomarFoto,)

       ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key:formKey ,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
      
    ); 
  }

 Widget _crearNombre(){
   return TextFormField(
     textCapitalization: TextCapitalization.sentences,
     initialValue: productoModels.titulo,
     decoration: InputDecoration(
       labelText: "Producto"
     ),
     onSaved: (newValue) {
       productoModels.titulo = newValue;
     },
     validator: ( value) {
       if(value.length < 3){
         return "ponga mas de tres caracteres";
       }else {
         return null;
       }
     },
   );
 }

 Widget _crearPrecio(){
   return TextFormField(
     initialValue: productoModels.valor.toString(),
     decoration: InputDecoration(
       labelText: "precio",

     ),
     keyboardType: TextInputType.numberWithOptions(decimal: true),
     onSaved: (newValue) {
       productoModels.valor = double.parse(newValue);
     },
     validator: (value) {
     if( utils.isNumeric(value)){
       return null;
     }
     return "solo numeros";
     },
     
   );
 }

 Widget _crearDisponible(){

   return SwitchListTile(
     title: Text("disponibilidad"),
     activeColor: Colors.deepPurple,
     value: productoModels.disponible, 
     onChanged: (value) {
       setState(() {
         
       });
       productoModels.disponible = value;
     },);
 }

Widget  _crearBoton(){
  return RaisedButton.icon( 
  icon: Icon(Icons.save), 
  label: Text("precioname"),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),),
  color: Colors.deepPurple,
  textColor: Colors.white,
  onPressed: (_guardando ) ?  null :_submit ,
  );
}

_submit(){

 if(!formKey.currentState.validate()){
   return;
 }

  formKey.currentState.save();
  setState(() {
  _guardando = true;
    
  });

  if(productoModels.id == null){
    productoProvider.crearProducto(productoModels);
    mostrarSnackbar("creado correctamente su usuario");
    }else{
      productoProvider.editarProducto(productoModels);
    mostrarSnackbar("actualizado correctamente todo");
  }
  
  Navigator.pop(context);
 

}

//aqui le paso el string del MENSAJE que queiro mostrar para poder reutilizar mi snacbar 
  void mostrarSnackbar( String mensaje){

//para poder mostrar un snackbar no puedo mostrarlo asi como tal , necesito una referencia al scafold , el scafol es quien puede emitir o mostrar este snacbar
    final snackbar = SnackBar(
      content: Text("$mensaje"),
      duration:Duration(seconds: 2),
      );
    
    scaffoldKey.currentState.showSnackBar(snackbar);

  }

  _mostrarFoto(){
    

    if(productoModels.fotoUrl != null){
      return Container();
    }else{

      return Image(
        image: AssetImage( foto?.path ??"assets/no-image.png"),
        width: double.infinity,
        height: 300.0,
        fit: BoxFit.cover,
      );

    }
  }


  _seleccionarFoto() async {
    final _picker =  ImagePicker();
    final _pickerFile = await _picker.getImage(
      source: ImageSource.gallery);

      foto = File(_pickerFile.path);

      if(foto !=null){
        //aqui hacemos una limpieza para que se pueda cambiar la foto si anteriormente habia otra.
        productoModels.fotoUrl = null;
      }

      setState(() {
        
      });

  }
  _tomarFoto(){

  }

}