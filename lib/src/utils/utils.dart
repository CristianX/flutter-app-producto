import 'package:flutter/material.dart';

// Determinando si es un número o no
bool esNumero( String s ) {

  if( s.isEmpty ) return false;

  // Conviertiendo a número (Si no lo puede hacer retorna un null)
  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}

void mostrarAlerta( BuildContext context, String mensaje ) {

  // Mostrando caja de diálogo
  showDialog(
    context: context,
    builder: ( context ) {
      return AlertDialog(
        title: Text('Información incorrrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(), //Cerrando notificación
          )
        ],
      );
    }
  );

}