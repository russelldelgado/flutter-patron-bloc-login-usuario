import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context)
        ],
      )
      
    );
  }

  Widget _loginForm(BuildContext context){

    final size = MediaQuery.of(context).size;
    //con esto le decimo que escale hasta encontrar en el contexto mi loginblock creado como podemos verr en el metodo de la clase provider
    final bloc = Provider.of(context);


    return SingleChildScrollView(
      child: Column(
        children: [

          SafeArea(child: Container(
            height: size.height * 0.30,
          )),

          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black26 , blurRadius: 3.0 , offset: Offset(0.0 , 5.0) , spreadRadius: 3.0  )
              ]              
            ),
            child: Column(
              children: [
                Text('Ingreso' , style:  TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0,),
                _crearEmail(bloc),
                SizedBox(height: 30.0,),
                _crearPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc), 


              ],
            ),
          ),
          SizedBox(height: 20.0,),

          Text('Olvido la contraseña?'),
          SizedBox(height: 100.0,)
                  
        ],
        
      ),
      
    );
  }

//pasando el bloc y retornando lo que es el stream builder podemos reaccionar segun vayan escribiendo datos
 Widget _crearEmail(LoginBloc bloc){
    
   return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (context, snapshot) {

          return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email , color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
           //esto es igual que lo de abajo , el primer argumento de mi onchange va a ser trasladado al primer valor de mi bloc.changeEmail
           // onChanged: (value) => bloc.changeEmail(value),
           onChanged: bloc.changeEmail,
          ),
        );
      },
      );
    }

    Widget _crearPassword(LoginBloc bloc){

      return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) {
          
          return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock , color: Colors.deepPurple,),
            labelText: 'password',
            counterText: snapshot.data,
            errorText: snapshot.error
          
          ),
          onChanged: bloc.changePassword,
        ),
      );
        },);

      
    }

    Widget _crearBoton(LoginBloc bloc){
      return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
              return RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0 , vertical: 15.0),
              child: Text('Ingresar'),
            ),
            onPressed: snapshot.hasData ? ()=>_login(bloc , context) : null,);
        },);
    }

    _login(LoginBloc block  , BuildContext context){
      print('======================================');
      print('email ${block.email}: ');
      print('password : ${block.password}');
      Navigator.pushReplacementNamed(context, 'home');
    }


  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size.height;

    final fondoMorado =  Container(
      height: size * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        ),
      ),
    );

    final circulo = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final texto = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Icon(Icons.person_pin_circle , color: Colors.white, size: 100.0,), 
          SizedBox(height: 10.0, width: double.infinity,),//con esto hacemos que se posicione en el centro porque el ancho ocupa todo 
          Text('Rusell delgado' ,style: TextStyle(color:  Colors.white , fontSize: 25.0),)
        ],
      ),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(child: circulo,top: 90.0,left: 30.0,),
        Positioned(child: circulo,top: -40.0,right: -30.0,),
        Positioned(child: circulo,bottom: -50.0,right: -10.0,),
        Positioned(child: circulo,bottom: 50.0,left: 20.0,),
        Positioned(child: circulo,bottom: 120.0,left: 120.0,),
        Positioned(child: circulo,bottom: 120.0,left: 120.0,),
        texto


      ],
    );

  }
}