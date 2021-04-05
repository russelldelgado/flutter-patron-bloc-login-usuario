import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
export  'package:formvalidation/src/bloc/login_bloc.dart'; // exporto login bloc para cuando utilice mi provider ya este implicito que se utilizara el loginbloc


class Provider extends InheritedWidget{

  //tengo que crearme un patron singleton que la primera vez reciba información y la siguiente vez la reutilice para que no perdamos toda la información 

  static Provider _instancia;

  //el objetivo de este factory es determinar si tengo que regresar una nueva instancia  de la clase o utilizar esta existente
  factory Provider({Key key , Widget child}){

    if(_instancia == null){
      _instancia = new Provider._internal(key: key , child: child,);
    }
    
    return _instancia;
  }

  Provider._internal({Key key , Widget child})
   : super(key: key , child: child);

  //el objetivo de este ejercicio es ver como se trabaja con un patron bloc par que todo  la información no se pierda
  //que se independiente de la pantalla

  //tengo que crear la instancia del bloc para manejar en todos los lugares la misma instancia de la información
  //una vez funciona todo lo qu epasa es que perdemos la data por eso hay que hacer algo para que no se pierda cuando hacemos un hotreload
  final loginBlock = LoginBloc();//esta es mi primera y unica instancia que voy a manejar de mi login bloc

  //Provider({Key key , Widget child})
   // : super(key: key , child: child); // con esto le digo que la key y el child son los mismo que recibo como argumento;


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  //necesito que me devuelva el estado de como esta ese login bloc
  //metodo estatico que devuelve un loginblock y se llama of , recibe el contexto que es el jefe arbol de todos los widgets
  static LoginBloc of(BuildContext context){
    //esto me va a devolver la instancia de mi loginBlock en este momento basada en este contexto
    //busca en todo mi arbol de widget la instancia de provider como provider y me devuelves el loginBlock de esa instancia
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBlock;
  }

}