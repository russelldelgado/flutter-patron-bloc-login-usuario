import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:admob_flutter/admob_flutter.dart';

 
void main() {
    //esto es necesario para inicializar el bloque de anuncio de admob
    WidgetsFlutterBinding.ensureInitialized();
    Admob.initialize();

  runApp(MyApp());
  //id de mi aplicación com.example.formvalidation
  }
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//este provider me sirve para trabjar con el patron bloc
//flutter recomienda que de esta manera manipulemos la información o el estado de la misma
    return Provider(

        child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login de usuario',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage()
        },
        theme: ThemeData(primaryColor: Colors.deepPurple),
      ),
    );
  }
}