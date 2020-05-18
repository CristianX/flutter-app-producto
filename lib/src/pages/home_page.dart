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
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: ( context, i ) => _crearItem( context, productos[i] ),
          );
        } else {
          return Center( child: CircularProgressIndicator() );
        }
      },
    );

  }

  // Creación del item para mostrar productos de Firebase
  Widget _crearItem( BuildContext context, ProductoModel producto ) {
    // Dismissible para acción al mover el item a la derecha o izquierda
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: ( direccion ){
        // Llamando borrar producto
        productosProvider.borrarProducto(producto.id);
      },
      child: ListTile(
        title: Text('${ producto.titulo } - ${ producto.valor }'),
        subtitle: Text( producto.id ),
        onTap: () => Navigator.pushNamed(context, 'producto'),
      ),
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