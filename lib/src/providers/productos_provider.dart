


// http
import 'package:http/http.dart' as http;

// Json
import 'dart:convert';

// Modelos
import 'package:formvalidation/src/models/producto_model.dart';

// Para el tipo de dato File
import 'dart:io';

// Mime type
import 'package:mime_type/mime_type.dart';

// Media Type
import 'package:http_parser/http_parser.dart';

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


  // Servicio para la subida de imagenes a cloudinary
  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/djs1a6zt6/image/upload?upload_preset=yvojsi9x');
    // Averiguando tipo de extensión
    final mimeType =mime( imagen.path ).split('/');  // => image/jpg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    // field es el campo body de file

    final file = await http.MultipartFile.fromPath(
      'file' , 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    // Extrayendo campo secure_url de la respuesta
    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];

  }


}