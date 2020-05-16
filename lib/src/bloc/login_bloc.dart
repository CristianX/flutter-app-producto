
// Stream Controller
import 'dart:async';

// Validators
import 'package:formvalidation/src/bloc/validators.dart';

// RX Dart
import 'package:rxdart/rxdart.dart';

class LoginBloc  with Validators {

  // Cambiando StreamController por BehaviorSubject para usar la extensión rx (Por defecto hace un broadcast)
  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );

  // Stream para validar si ambos tienen data (Combinando streams)
  Stream<bool> get formValidStream =>  CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  // Getters y Setters

  // Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Getters
  // Obteniendo último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;


  // Cerrando Streams
  dispose() {
    _emailController?.close();
    _passwordController.close();
  }






}