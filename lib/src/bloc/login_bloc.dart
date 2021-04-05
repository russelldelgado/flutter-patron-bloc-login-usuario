

import 'dart:async';
import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

//mediante un mixin importo la validación para mezclarlo con este archivo

class LoginBloc with Validators{
//el broadcast es para qeu varias instancias puedan estar escuchando sus cambios si no solo una lo haria.
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //esto me vale para ir escuchando los cambios que ocurren en el streambuilder , para poder mostrar algo segun va cambiando
  //recuperar los datos del stream , salida del mismo 
  //Stream<String> quiere decir que lo que sale de este stream son string , este rio lo que continen son stream
   Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
   Stream<String> get emailStream => _emailController.stream.transform(validarEmail); // puedo ir escuchando lo que sale de aquí mediante est email stream

  //insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;



  //usaremos la libreria rxdart para poder trabjar mas comodamente a la hora de hacer lo que es una validación de que dos stream tengan datos
  //los combinelates no trabajan con stream controller por eso tenemos que cambiar las lieas de streamController por behaviorSubject<string>
  //le pasamos el emailstream ya validado que pasa por mi tranform e igual con la password
  //por ultimo le pasamos el callback a llamar cuando tengamos información de ambos stream , e => emailstream , p => passwordstream
  //si tenemos informacion en ambas retornamos un true
  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);


  //obtener el ultimo valor ingresado a los stream
  //el value lo podemos obtener porque usamos behaviorSubject....
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }


}