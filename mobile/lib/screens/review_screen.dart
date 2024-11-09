import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/service/movie_service.dart';
import 'add_review_screen.dart';

class ReviewsScreen extends StatefulWidget {
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final MovieService movieService = MovieService();
  late Future<List<Review>> reviews;

  @override
  void initState() {
    super.initState();
    reviews =
        movieService.fetchReviews(); // Chama o serviço para pegar as avaliações
  }

  // Função para atualizar a lista de avaliações após editar ou deletar
  void refreshReviews() {
    setState(() {
      reviews = movieService.fetchReviews(); // Refresca a lista de avaliações
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações'),
      ),
      body: FutureBuilder<List<Review>>(
        future: reviews, // Espera o resultado da chamada assíncrona
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Mostra um carregamento
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Erro ao carregar avaliações: ${snapshot.error}'), // Mostra erro se houver
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                  'Nenhuma avaliação encontrada'), // Caso não tenha avaliações
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length, // Conta as avaliações
              itemBuilder: (context, index) {
                var review = snapshot.data![index]; // Pega a avaliação
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(review.nomeFilme), // Nome do filme
                    subtitle: Text(
                        'Nota: ${review.nota} - ${review.descricao}'), // Nota e descrição
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botão de editar avaliação
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddReviewScreen(
                                  reviewData:
                                      review, // Passa os dados da avaliação para edição
                                  onSave:
                                      refreshReviews, // Atualiza as avaliações após salvar
                                ),
                              ),
                            );
                          },
                        ),
                        // Botão de deletar avaliação
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Deletar Avaliação'),
                                content: Text(
                                    'Tem certeza que deseja deletar esta avaliação?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text('Deletar'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              try {
                                await movieService.deleteReview(review.id
                                    .toString()); // Passa id como String
                                refreshReviews(); // Atualiza a lista de avaliações
                              } catch (e) {
                                print('Erro ao deletar avaliação: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Erro ao deletar a avaliação')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReviewScreen(onSave: refreshReviews),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
