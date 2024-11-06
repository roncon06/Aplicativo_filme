// lib/models/filme.dart
class Filme {
  final int id;
  final String titulo;
  final String diretor;
  final String descricao;
  final double preco;
  final int categoriaId;

  Filme({
    required this.id,
    required this.titulo,
    required this.diretor,
    required this.descricao,
    required this.preco,
    required this.categoriaId,
  });

  // Método de fábrica para criar um Filme a partir de um JSON
  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'],
      titulo: json['titulo'],
      diretor: json['diretor'],
      descricao: json['descricao'],
      preco: json['preco'].toDouble(),
      categoriaId: json['categoriaId'],
    );
  }

  // Método para converter um Filme em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'diretor': diretor,
      'descricao': descricao,
      'preco': preco,
      'categoriaId': categoriaId,
    };
  }
}
