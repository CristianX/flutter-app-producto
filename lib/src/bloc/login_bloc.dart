
// Stream Controller
import 'dart:async';

// Validators
import 'package:formvalidation/src/bloc/validators.dart';

class LoginBloc  with Validators {


  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );

  // Getters y Setters

  // Insertar valores al stream
  Function (String) get changeEmail => _emailController.sink.add;
  Function (String) get changePassword => _passwordController.sink.add;


  // Cerrando Streams
  dispose() {
    _emailController?.close();
    _passwordController.close();
  }






}