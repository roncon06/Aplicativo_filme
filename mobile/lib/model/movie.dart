import 'package:mobile/model/review.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  List<Review> reviews;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.reviews = const [],
  });

  // Método para converter dados JSON para objeto Movie
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
    );
  }

  // Método para converter objeto Movie para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }
}
