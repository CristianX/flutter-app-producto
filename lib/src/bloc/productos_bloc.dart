
// Reactivo para BehaviorSubject
import 'package:rxdart/rxdart.dart';

// File
import 'dart:io';


// Modelos
import 'package:formvalidation/src/models/producto_model.dart';

// Providers personalizados
import 'package:formvalidation/src/providers/productos_provider.dart';

class ProductosBloc{

  // Streams para el listado completo de productos
  // BehaviorSubject manda broadcast por defecto
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  // Streams para cuando está cargando información
  final _cargandoController = new BehaviorSubject<bool>();

  // Referencia a productos provider
  final _productosProvider = new ProductosProvider();

  // Escuchando los streams
  Stream <List<ProductoModel>> get productosStream => _productosController.stream;
  Stream <bool> get cargandoStream => _cargandoController.stream;

  // GET productos
  void cargarProductos() async {

    final productos = await _productosProvider.cargarProducto();

    // Insertando productos al stream
    _productosController.sink.add( productos );

  }

  // POST producto
  void agregarProducto( ProductoModel producto ) async {

    // Verificar si está cargando información
    _cargandoController.sink.add(true);

    await _productosProvider.crearProducto(producto);
    // TODO: Controlar si se graba o no se graba

    // Notificando que ya no se está cargando
    _cargandoController.sink.add(false);

  }

  // POST foto
  Future<String> subirFoto( File foto ) async {

    // Verificar si está cargando información
    _cargandoController.sink.add(true);

    final fotoUrl = await _productosProvider.subirImagen(foto);
    // TODO: Controlar si se graba o no se graba

    // Notificando que ya no se está cargando
    _cargandoController.sink.add(false);


    return fotoUrl;

  }

  // PUT editar producto
  void editarProducto( ProductoModel producto ) async {

    // Verificar si está cargando información
    _cargandoController.sink.add(true);

    await _productosProvider.editarProducto(producto);
    // TODO: Controlar si se graba o no se graba

    // Notificando que ya no se está cargando
    _cargandoController.sink.add(false);

  }

  // DELETE producto
  void borrarProducto( String id ) async {

    await _productosProvider.borrarProducto(id);

  }


  


  dispose() {
    // Cerrando streams
    _productosController?.close();
    _cargandoController?.close();
  }

}