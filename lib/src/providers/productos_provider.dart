

// http
import 'package:http/http.dart' as http;

// Json
import 'dart:convert';

// Modelos
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-84be6.firebaseio.com';

  Future<bool> crearProducto( ProductoModel producto ) async {

    // Para usar el Respt Api de firebase siempre hay que agregar el .json
    final url = '$_url/productos.json';

    final resp = await http.post( url, body: productoModelToJson( producto ));

    final decodedData = json.decode( resp.body );

    print( decodedData );

    return true;

  }

}