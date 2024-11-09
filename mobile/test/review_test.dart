import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/model/review.dart';

void main() {
  test('deve criar uma avaliação corretamente', () {
    final review = Review(
      id: '1',
      movieId: 101,
      nomeFilme: 'Interestelar',
      nota: 4.5,
      descricao: 'Um filme incrível sobre espaço e tempo.',
    );

    expect(review.id, '1');
    expect(review.movieId, 101);
    expect(review.nomeFilme, 'Interestelar');
    expect(review.nota, 4.5);
    expect(review.descricao, 'Um filme incrível sobre espaço e tempo.');
  });

  test('deve converter uma avaliação para JSON corretamente', () {
    final review = Review(
      id: '1',
      movieId: 101,
      nomeFilme: 'Interestelar',
      nota: 4.5,
      descricao: 'Um filme incrível sobre espaço e tempo.',
    );

    final json = review.toJson();

    expect(json['id'], '1');
    expect(json['movieId'], 101);
    expect(json['nomeFilme'], 'Interestelar');
    expect(json['nota'], 4.5);
    expect(json['descricao'], 'Um filme incrível sobre espaço e tempo.');
  });

  test('deve criar uma avaliação a partir de JSON corretamente', () {
    final json = {
      'id': '1',
      'movieId': 101,
      'nomeFilme': 'Interestelar',
      'nota': 4.5,
      'descricao': 'Um filme incrível sobre espaço e tempo.',
    };

    final review = Review.fromJson(json);

    expect(review.id, '1');
    expect(review.movieId, 101);
    expect(review.nomeFilme, 'Interestelar');
    expect(review.nota, 4.5);
    expect(review.descricao, 'Um filme incrível sobre espaço e tempo.');
  });
}
