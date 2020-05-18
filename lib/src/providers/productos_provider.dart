

// http
import 'package:http/http.dart' as http;

// Json
import 'dart:convert';

// Modelos
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-84be6.firebaseio.com';

  // POST de productos
  Future<bool> crearProducto( ProductoModel producto ) async {

    // Para usar el Respt Api de firebase siempre hay que agregar el .json
    final url = '$_url/productos.json';

    final resp = await http.post( url, body: productoModelToJson( producto ));

    final decodedData = json.decode( resp.body );

    print( decodedData );

    return true;

  }


  // GET de productos
  Future<List<ProductoModel>> cargarProducto() async {

    // Llamando url de producto
    final url  = '$_url/productos.json';

    // Realizando petición get
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );

    // print( decodedData );

    final List<ProductoModel> productos = new List();

    if( decodedData == null ) return [];

    decodedData.forEach((id, prod) {

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add( prodTemp );

    });

    // print(productos[0].id);

    return productos;

  }

  // DELETE de productos
  Future<int> borrarProducto( String id ) async {

    final url = '$_url/productos/$id.json';

    final resp = await http.delete(url);

    // Regresa null si todo sale bien o una descripción si regresa un error
    print( resp.body );

    return 1;

  }

  // PUT de productos
  Future<bool> editarProducto( ProductoModel producto ) async {

    // Para usar el Respt Api de firebase siempre hay que agregar el .json
    final url = '$_url/productos/${ producto.id }.json';

    final resp = await http.put( url, body: productoModelToJson( producto ));

    final decodedData = json.decode( resp.body );

    print( decodedData );

    return true;

  }

}