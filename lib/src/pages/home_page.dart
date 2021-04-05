import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


  final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("HOME PAGE"),),
       body: Container(
         
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Email : ${bloc.email} '),
             Divider(),
             Text('password : ${bloc.password} '),
           ],
         ),
       ),
    );

  }
}