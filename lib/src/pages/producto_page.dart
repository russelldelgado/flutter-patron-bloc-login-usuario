import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_models.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {


  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
final formKey = GlobalKey<FormState>();
 final productoProvider = new ProductosProviders();

ProductoModels productoModels = ProductoModels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Producto"),
       actions: [
         IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () {},),
         IconButton(icon: Icon(Icons.camera_alt), onPressed: () {},)

       ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key:formKey ,
            child: Column(
              children: [
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
  onPressed: _submit,
  );
}

_submit(){

 if(!formKey.currentState.validate()){
   return;
 }

  formKey.currentState.save();
 print("todo ok");
 print(productoModels.titulo);
 print(productoModels.valor);
 print(productoModels.disponible);

productoProvider.crearProducto(productoModels);
 

}
}