import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/review.dart';

class MovieService {
  final String apiKey = '0e7fe22009c021fccf280f6da08bf7a8';

  // URL base da API de filmes
  String get apiUrl =>
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR';

  // Função para buscar filmes populares
  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }

// Função para adicionar uma avaliação
  Future<void> addReview(Review reviewData) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reviewData.toJson()), // Convertendo Review para Map
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar avaliação');
    }
  }

  // Função para buscar todas as avaliações
  Future<List<Review>> fetchReviews() async {
    final response = await http.get(Uri.parse('http://localhost:3000/reviews'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data
          .map((reviewData) => Review.fromJson(reviewData))
          .toList(); // Convertendo Map para Review
    } else {
      throw Exception('Falha ao carregar avaliações');
    }
  }

  // Função para atualizar a avaliação
  Future<void> updateReview(String id, Review review) async {
    final url = Uri.parse('http://localhost:3000/reviews/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'movieId': review.movieId,
          'nomeFilme': review.nomeFilme,
          'nota': review.nota,
          'descricao': review.descricao,
        }),
      );

      if (response.statusCode == 200) {
        print('Avaliação atualizada com sucesso!');
      } else {
        throw Exception('Falha ao atualizar avaliação');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar avaliação: $e');
    }
  }

  // Função para deletar a avaliação
  Future<void> deleteReview(String id) async {
    final url = Uri.parse('http://localhost:3000/reviews/$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Avaliação deletada com sucesso!');
      } else {
        throw Exception('Falha ao deletar avaliação');
      }
    } catch (e) {
      throw Exception('Erro ao deletar avaliação: $e');
    }
  }
}
