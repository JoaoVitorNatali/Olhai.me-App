bool validaEmail(String user){
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(user);
}

bool validaTelefone(String user){
  bool hasCharInvalid = RegExp(r'[a-zA-Z\u00C0-\u00FF\$\+\%\¨\& ]+', caseSensitive: false).hasMatch(user);
  if(hasCharInvalid){
    return false;
  }
  String telefone = user.replaceAll('(', '').replaceAll(')', '');

  return (telefone.length == 11);
}

String? validaTelefoneEmail(String? user){
  if(user!.isEmpty) return "O campo é obrigatório";
  else if(!validaTelefone(user) && !validaEmail(user)){
    return "E-mail ou telefone inválidos\nTelefone deve conter ddd (2 digitos) + 9 digitos";
  }
  else return null;
}