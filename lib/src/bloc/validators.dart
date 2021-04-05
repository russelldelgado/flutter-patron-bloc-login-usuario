//gracias a la habilidad que nos ofrece el mixis podemos reutilizar todas las validacioes en otras clases
//
//
import 'dart:async';

class Validators {

  //hacemos lo mismo que en validar password
  //
  final validarEmail = StreamTransformer<String , String>.fromHandlers(
    handleData: (email, sink) {
     
     //codigo de validacion de correo electronico
     //Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
     Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

     //ahora tengo que crearme una expresion regular basada en el patron que tengo arriba
     RegExp regExp = new RegExp(pattern);

    //esto quiere decir que si la informacion del correo es valida entonces dejamos fluir esa informacion por el stream
     if(regExp.hasMatch(email)){
       sink.add(email);
     }else{
       sink.addError('Correo electronico invalido');
     }
     

    },
  );


  //es importante decir que informacion entra y que informacion sale del string transformer <string , string>
  ////puede ser cualquier tipo de salida
  final validarPassword = StreamTransformer<String , String>.fromHandlers(
    handleData:(password, sink) {
      //el sink me indica que información esta fluyendo o que informacion hay un error y hay que bloquearlo
    
      if(password.length >= 6){
        sink.add(password); // con esto le digo que deje fluir esta contraseña
      }else {
        sink.addError('Mas de 6 caracteres porfavor');
      }

    }, 
  );
}