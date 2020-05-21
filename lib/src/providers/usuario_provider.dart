// Http
import 'dart:convert';

// Json
import 'package:http/http.dart' as http;

// Certificate
import 'package:formvalidation/src/certificate/certificate.dart';


class UsuarioProvider {

  Future nuevoUsuario( String email, String password ) async {

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

    print( decodedResp );

    // Mostrando error de cuenta existente
    if( decodedResp.containsKey('idToken')) {
      // TODO: salvar toque en el storage
      return {'ok': true, 'token': decodedResp['idToken'] };
    } else {
      // Para apuntar un mapa dentro de otro mapa decodedResp['error']['message'] 
      return {'ok': true, 'false': decodedResp['error']['message'] };
    }

  }

}