import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_models.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';

class HomePage extends StatelessWidget {
  final productosProviders =  ProductosProviders();

  @override
  Widget build(BuildContext context) {
  final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("HOME PAGE"),),
       body: _crearListado(),
       floatingActionButton: _crearBoton(context),
    );

  }

   Widget _crearListado(){
     
     return FutureBuilder<List<ProductoModels>>(
       future:productosProviders.cargarProductos() ,
       initialData: [],
       builder: (context, AsyncSnapshot <List<ProductoModels>>snapshot) {
         

         if(snapshot.hasData) {

             final productos = snapshot.data;

         return ListView.builder(
           itemCount: productos.length,
           
           itemBuilder: (context, i)=> _crearItem(context , productos[i]),);
         }else{
           return Center(child: CircularProgressIndicator(),);
         }
       },
       );
   }

  Widget _crearItem(BuildContext context ,ProductoModels producto){

    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red,),
      onDismissed: (direction) {
        //borrar producto
        productosProviders.eliminarRegistro(producto.id);
      },
          child: ListTile(
        title: Text('${producto.titulo} ${producto.valor}'),
        subtitle: Text( '${producto.id} '),
        onTap: (){
          Navigator.pushNamed(context, "producto" , arguments: producto);
        },
      ),
    );
  }

  Widget _crearBoton(BuildContext context){

    return FloatingActionButton(onPressed: () {
      Navigator.pushNamed(context, "producto");
    },
    child: Icon(Icons.add),
    backgroundColor: Colors.deepPurple,
    );
  }
}