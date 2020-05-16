import 'package:flutter/material.dart';

// Utils
import 'package:formvalidation/src/utils/utils.dart' as utils;

// Para trabajar con forms se lo debe hacer con un StatefulWidget
class ProductoPage extends StatefulWidget {

  // Key del formulario para controlar el estado del Form
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ), 
            onPressed: () {}
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ), 
            onPressed: () {}
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            // Identificador único de este formulario (key)
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    // TextFormField trabaja directamente con un Form (Formulario)
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      // Validación del Form
      validator: ( value ) {
        if( value.length < 3 ) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      // Para aplicar punto decimal en el campo de texto numberWithOptions
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      // Validación del Form
      validator: ( value ) {

        if( utils.esNumero(value) ) {
          return null;
        } else {
          return 'Solo números';
        }

      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: _submit
    );
  }

  void _submit() {

    if( !formKey.currentState.validate() ) return;

    print( 'Todo OK!' );

  }
}