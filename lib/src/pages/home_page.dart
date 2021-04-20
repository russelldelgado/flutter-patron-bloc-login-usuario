import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


  final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("HOME PAGE"),),
       body: Container(
         
         child: Column(),
       ),
       floatingActionButton: _crearBoton(context),
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