import 'package:flutter/material.dart';

// Provider
import 'package:formvalidation/src/bloc/provider.dart';

// Modelos
import 'package:formvalidation/src/models/producto_model.dart';

// Productos provider
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {


  // Llamando productos provider
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    // Llama el of que irá escalando la instancia del Provider en la clase Provider
    final bloc = Provider.of(context);

    

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton( context ),
      
    );
  }

  Widget _crearListado() {

    return FutureBuilder(
      future: productosProvider.cargarProducto(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if( snapshot.hasData ) {
          return Container();
        } else {
          return Center( child: CircularProgressIndicator() );
        }
      },
    );

  }

  Widget _crearBoton( BuildContext context ) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

}