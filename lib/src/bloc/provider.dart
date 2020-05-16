// Inherited Widget personalizado ( Alternativa al patrón Singleton recomendada por Flutter )

import 'package:flutter/material.dart';

// Streams
import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {


  final loginBloc = LoginBloc();

  // Key es un indentificador único del widget; el windget child es para mandar el widget ancestro MaterialApp
  Provider({ Key key, Widget child }) : super( key: key , child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // Busca internamente en el arbol de widgets retornará la instancia del bloc basada en context
  static LoginBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }


}