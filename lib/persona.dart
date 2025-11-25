class Persona {
  Persona({
    required this.nome,
    required this.cognome,
    required this.telefoni,
  });

  String nome;
  String cognome;
  List<String> telefoni;
  
  String get nomeCompleto => "$nome $cognome";

  String get testoCondivisione {
    String telefonoString = telefoni.join(" / ");
    return "Contatto: $nomeCompleto\nNumeri: $telefonoString";
  }
}