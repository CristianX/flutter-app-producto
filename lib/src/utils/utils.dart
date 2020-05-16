// Determinando si es un número o no
bool esNumero( String s ) {

  if( s.isEmpty ) return false;

  // Conviertiendo a número (Si no lo puede hacer retorna un null)
  final n = num.tryParse(s);

  return ( n == null ) ? false : true;

}