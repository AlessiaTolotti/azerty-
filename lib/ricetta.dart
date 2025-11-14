class Ricetta {
  String nome;
  String descrizione;
  String url;
  List<String> ingredienti;
  List<String> steps;

  Ricetta({
    required this.nome,
    required this.descrizione,
    required this.url,
    this.ingredienti = const [],
    this.steps = const [],
  });
}