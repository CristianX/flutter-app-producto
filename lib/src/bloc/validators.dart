
// Stream Transformer
import 'dart:async';

class Validators {


  // Entrada String salida String <String, String>
  final validarPassword = StreamTransformer<String, String>.fromHandlers( 
    // Sink dice que informacipón sigue fluyendo o cual tiene error y lo bloquea
    handleData: ( password, sink ) {

      if( password.length >= 6 ) {
        sink.add( password );
      } else {
        sink.addError( 'La contraseña debe tener más de 6 carácteres' );
      }

    }
   );

   // Entrada String salida String <String, String>
  final validarEmail = StreamTransformer<String, String>.fromHandlers( 
    // Sink dice que informacipón sigue fluyendo o cual tiene error y lo bloquea
    handleData: ( email, sink ) {

      // Patrón de validación de correo
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if( regExp.hasMatch( email ) ) {
        sink.add( email );
      } else {
        sink.addError( 'Email no es correcto' );
      }

    }
   );


}