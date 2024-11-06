import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mobile/screens/listagem_screen.dart';
import 'package:mobile/model/filme.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('deve criar um filme corretamente', () {
    final filme = Filme(
      id: 1,
      titulo: "Interestelar",
      diretor: "Christopher Nolan",
      descricao: "Uma viagem pelo espaço em busca de um novo lar.",
      preco: 24.90,
      categoriaId: 1,
    );

    expect(filme.titulo, "Interestelar");
    expect(filme.diretor, "Christopher Nolan");
    expect(filme.preco, 24.90);
  });

  test('deve criar vários filmes corretamente', () {
    final filmes = [
      Filme(
          id: 1,
          titulo: "O Poderoso Chefão",
          diretor: "Francis Ford Coppola",
          descricao: "",
          preco: 19.90,
          categoriaId: 1),
      Filme(
          id: 2,
          titulo: "Clube da Luta",
          diretor: "David Fincher",
          descricao: "",
          preco: 22.90,
          categoriaId: 2),
    ];

    expect(filmes.length, 2);
    expect(filmes[0].titulo, "O Poderoso Chefão");
    expect(filmes[1].titulo, "Clube da Luta");
  });

  testWidgets('deve buscar filmes e exibir na ListagemScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ListagemScreen()));

    expect(find.text("Interestelar"), findsOneWidget);
    expect(find.text("O Poderoso Chefão"), findsOneWidget);
    expect(find.text("Clube da Luta"), findsOneWidget);
  });

  test('teste mock com http.Client para buscar filmes', () async {
    final client = MockClient();

    // Simula uma resposta da API com uma lista de filmes vazia
    when(client.get(Uri.parse('http://localhost:3000/movies')))
        .thenAnswer((_) async => http.Response('{"filmes": []}', 200));

    final response =
        await client.get(Uri.parse('http://localhost:3000/movies'));

    expect(response, isA<http.Response>());
    expect(response.statusCode, 200);
    expect(response.body, '{"filmes": []}');
  });
}
