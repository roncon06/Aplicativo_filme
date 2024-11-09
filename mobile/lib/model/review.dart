class Review {
  final String id; // id é do tipo String
  final int movieId;
  final String nomeFilme;
  final double nota;
  final String descricao;

  Review({
    required this.id, // id é do tipo String
    required this.movieId,
    required this.nomeFilme,
    required this.nota,
    required this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movieId': movieId,
      'nomeFilme': nomeFilme,
      'nota': nota,
      'descricao': descricao,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'].toString(), // Converter para String caso necessário
      movieId: json['movieId'],
      nomeFilme: json['nomeFilme'],
      nota: json['nota'],
      descricao: json['descricao'],
    );
  }
}
