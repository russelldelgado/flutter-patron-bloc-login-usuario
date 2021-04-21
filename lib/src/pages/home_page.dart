import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_models.dart';
import 'package:formvalidation/src/providers/productos_providers.dart';
import 'package:formvalidation/src/widgets/miDrawer.dart';

class HomePage extends StatelessWidget {
  final productosProviders =  ProductosProviders();

  @override
  Widget build(BuildContext context) {
  final bloc = Provider.of(context);

    return Scaffold(
      drawer: retornarDrawable(),
      appBar: AppBar(title: Text("COMRANDY"), centerTitle: true,),
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
          child: Card(
            elevation: 10,
          
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                //hacemos comprobaciones de si hay o no fotografias en nuestra url
                (producto.fotoUrl ==null) 
                    ? Image(image: AssetImage("assets/no-image.png"),) 
                    : FadeInImage(placeholder:AssetImage("assets/jar-loading.gif") , image: NetworkImage(producto.fotoUrl) , height: 300.0 ,  width: double.infinity , fit: BoxFit.cover,),
                  Container(
                    color: (producto.disponible) ? Colors.green : Colors.red,
                    child: ListTile(
                      focusColor: (producto.disponible) ? Colors.green : Colors.red,
                    title: Text('${producto.titulo} ${producto.valor}'),
                    subtitle: Text( 'touch me !!!'),
                    onTap: (){
                Navigator.pushNamed(context, "producto" , arguments: producto);
        },
      ),
                  ),
              ],
            ),
          )
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