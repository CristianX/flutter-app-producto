import 'package:flutter/material.dart';

// Modelo
import 'package:formvalidation/src/models/producto_model.dart';

// Utils
import 'package:formvalidation/src/utils/utils.dart' as utils;

// Para trabajar con forms se lo debe hacer con un StatefulWidget
class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  // Key del formulario para controlar el estado del Form
  final formKey = GlobalKey<FormState>();

  // Llamada al modelo
  ProductoModel producto = new ProductoModel();

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
                _crearDisponible(),
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
      // Valores iniciales desde el modelo
      initialValue: producto.titulo,
      // Se ejecuta después de haber validado el campo
      onSaved: (value) => producto.titulo = value,
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
      // Valores iniciales desde el modelo
      initialValue: producto.valor.toString(),
      // Se ejecuta después de haber validado el campo
      onSaved: (value) => producto.valor = double.parse(value),
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


  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState((){
        producto.disponible = value;
      }),
    );
  }

  void _submit() {

    // Validando el formulario
    if( !formKey.currentState.validate() ) return;

    // Se debe ejecutar despúes de habee validado el formulario
    formKey.currentState.save();
    
    print( producto.titulo );
    print( producto.valor );
    print( producto.disponible );

  }
}