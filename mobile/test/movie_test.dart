import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/movie.dart';

void main() {
  test('deve criar um filme corretamente', () {
    final movie = Movie(
      id: 1,
      title: 'Interestelar',
      posterPath: '/path/to/poster',
    );

    expect(movie.id, 1);
    expect(movie.title, 'Interestelar');
    expect(movie.posterPath, '/path/to/poster');
    expect(movie.reviews,
        isEmpty); // A lista de reviews deve estar vazia por padrão
  });

  test('deve converter um filme para JSON corretamente', () {
    final movie = Movie(
      id: 1,
      title: 'Interestelar',
      posterPath: '/path/to/poster',
    );

    final json = movie.toJson();

    expect(json['id'], 1);
    expect(json['title'], 'Interestelar');
    expect(json['poster_path'], '/path/to/poster');
  });

  test('deve criar um filme a partir de JSON corretamente', () {
    final json = {
      'id': 1,
      'title': 'Interestelar',
      'poster_path': '/path/to/poster',
    };

    final movie = Movie.fromJson(json);

    expect(movie.id, 1);
    expect(movie.title, 'Interestelar');
    expect(movie.posterPath, '/path/to/poster');
  });

  test('deve inicializar reviews como lista vazia por padrão', () {
    final movie = Movie(
      id: 1,
      title: 'Interestelar',
      posterPath: '/path/to/poster',
    );

    expect(
        movie.reviews, isEmpty); // A lista de reviews deve ser vazia por padrão
  });
}
