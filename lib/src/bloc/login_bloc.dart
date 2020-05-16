
// Stream Controller
import 'dart:async';

class LoginBloc {


  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  // Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

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