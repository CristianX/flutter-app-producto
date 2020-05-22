// Http
import 'dart:convert';

// Json
import 'package:http/http.dart' as http;

// Certificate
import 'package:formvalidation/src/certificate/certificate.dart';

// Preferencias Usuario
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {

  // Instancia de preferencias de usuario
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login( String email, String password ) async {

     final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${ Certificate.firebaseToken }',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    // print( decodedResp );

    // Mostrando error de cuenta existente
    if( decodedResp.containsKey('idToken')) {
      // salvar toquen en el storage
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken'] };
    } else {
      // Para apuntar un mapa dentro de otro mapa decodedResp['error']['message'] 
      return {'ok': false, 'mensaje': decodedResp['error']['message'] };
    }

  }


  Future<Map<String, dynamic>> nuevoUsuario( String email, String password ) async {

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${ Certificate.firebaseToken }',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    // print( decodedResp );

    // Mostrando error de cuenta existente
    if( decodedResp.containsKey('idToken')) {
      // salvar toquen en el storage
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken'] };
    } else {
      // Para apuntar un mapa dentro de otro mapa decodedResp['error']['message'] 
      return {'ok': false, 'mensaje': decodedResp['error']['message'] };
    }

  }

}