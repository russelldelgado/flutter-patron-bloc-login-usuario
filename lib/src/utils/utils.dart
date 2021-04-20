

bool isNumeric(String s){
  if(s.isEmpty){
    return false;
  }
  //de esta manera se si se puede o no parsear a un numero ya que si no se puede me devolvera un null
  final n = num.tryParse(s);

  if(n == null){
    return false;
  }
  return true;
}