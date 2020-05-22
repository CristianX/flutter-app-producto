// Inherited Widget personalizado ( Alternativa al patrón Singleton recomendada por Flutter )

import 'package:flutter/material.dart';

// Streams
import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/productos_bloc.dart';

class Provider extends InheritedWidget {

  // Patrón singleton para no reinicializar el LoginBloc y mantener la data
  static Provider _instancia;

  // Bloc de login
   final _loginBloc     = new LoginBloc();

  //  Bloc de Productos
  final _productosBloc = new ProductosBloc();

  // Determina si se necesita regresar una nueva instancia de la clase o utilizar la existente
  factory Provider( {Key key, Widget child} ) {

    if( _instancia == null ) {
      // _internal previene que se pueda inicializar esta clase desde afuera
      _instancia = new Provider._internal( key: key, child: child, );
    }

    return _instancia;

  }
  
  // Key es un indentificador único del widget; el windget child es para mandar el widget ancestro MaterialApp
  Provider._internal({ Key key, Widget child }) : super( key: key , child: child );


 




  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // Busca internamente en el arbol de widgets retornará la instancia del bloc basada en context
  static LoginBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  // Busca internamente en el arbol de widgets retornará la instancia del bloc basada en context
  static ProductosBloc productosBloc ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  }


}