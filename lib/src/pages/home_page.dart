import 'package:flutter/material.dart';

// Provider
import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Llama el of que irá escalando la instancia del Provider en la clase Provider
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${ bloc.email } '),
          Divider(),
          Text('Password: ${ bloc.password } ')
        ],
      ),
      
    );
  }
}