
import 'package:flutter/material.dart';

// Modelo
import 'package:formvalidation/src/models/producto_model.dart';

// Provider
import 'package:formvalidation/src/providers/productos_provider.dart';

// Utils
import 'package:formvalidation/src/utils/utils.dart' as utils;

// Image Picker
import 'package:image_picker/image_picker.dart';

// Tipo de dato File
import 'dart:io';

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
  // Llamando producto provider
  final productoProvider = new ProductosProvider();
  // Referencia al scaffolt para utilizar snackbar
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // Para controlar la doble presión en el boton de guardar
  bool _guardando = false;
  // Controlar instancia de ImagePicker
  File foto;

  @override
  Widget build(BuildContext context) {

    // Tomando argumentos del navigator de home_page
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    // Evaluando si producto viene con algún elemento
    if( prodData != null ) {
      producto = prodData;
    }

    return Scaffold(
      // Para uso de snackbar
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.photo_size_select_actual ), 
            onPressed: () => _procesarImagen( ImageSource.gallery )
          ),
          IconButton(
            icon: Icon( Icons.camera_alt ), 
            onPressed: () => _procesarImagen( ImageSource.camera )
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
                _mostrarFoto(),
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
      onPressed: (_guardando) ? null : _submit
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

  void _submit() async {

    // Validando el formulario
    if( !formKey.currentState.validate() ) return;

    // Se debe ejecutar despúes de habee validado el formulario
    formKey.currentState.save();
    
    // print( producto.titulo );
    // print( producto.valor );
    // print( producto.disponible );

    setState(() {_guardando = true;});

    // Al momento que se detecte que se va a subir una imagen hay que deshabilitar el boton
    if( foto != null ) {
      producto.fotoUrl = await productoProvider.subirImagen(foto);
    }

    // Diferenciando si es una carga o acualización de datos
    if( producto.id == null ){
      productoProvider.crearProducto( producto );
    } else {
      productoProvider.editarProducto( producto );
    }

    // setState(() {_guardando = false;});
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);

  }

  void mostrarSnackbar( String mensaje ) {

    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500 ),
    );

    // Mostrando snackbar con la referencia del Scaffold scanfflodKey
    scaffoldKey.currentState.showSnackBar(snackbar);

  }


  Widget _mostrarFoto() {

    if( producto.fotoUrl != null ) {
      return Container();
    } else {
      return Image(
        // ? si la foto tiene algo regresa el path ?? si la foto no tiene nada regresa la imagen
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }

  }


  // void _seleccionarFoto() async {

  //   foto = await ImagePicker.pickImage(
  //     source: ImageSource.gallery
  //   );

  //   // Si cancela o no selecciona niguna foto
  //   if( foto != null ) {
  //     // limpieza
  //   }

  //   setState(() {});

  // }

  // void _tomarFoto() async {

  //   _procesarImagen( ImageSource.camera );

  // }
  // Optimización de código
  void _procesarImagen( ImageSource tipo ) async {

    foto = await ImagePicker.pickImage(
      source: tipo
    );

    // Si cancela o no selecciona niguna foto
    if( foto != null ) {
      // limpieza
    }

    setState(() {});


  }

}