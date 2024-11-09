import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/service/movie_service.dart';

class AddReviewScreen extends StatefulWidget {
  final Review? reviewData;
  final VoidCallback? onSave;

  AddReviewScreen({this.reviewData, this.onSave});

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final MovieService movieService = MovieService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.reviewData != null) {
      nameController.text = widget.reviewData!.nomeFilme;
      ratingController.text = widget.reviewData!.nota.toString();
      descriptionController.text = widget.reviewData!.descricao;
    }
  }

  Future<void> saveReview() async {
    final reviewData = Review(
      id: widget.reviewData?.id ?? '0', // Garantir que id seja uma string
      movieId: widget.reviewData?.movieId ?? 1, // Ajuste conforme necessário
      nomeFilme: nameController.text,
      nota: double.parse(ratingController.text),
      descricao: descriptionController.text,
    );

    // Se for nova avaliação, chama o método para adicionar, senão atualiza
    if (widget.reviewData == null) {
      await movieService.addReview(reviewData);
    } else {
      await movieService.updateReview(
          reviewData.id, reviewData); // Passando o id como String
    }

    widget.onSave?.call();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.reviewData == null
              ? 'Adicionar Avaliação'
              : 'Editar Avaliação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo para nome do filme
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Filme'),
            ),
            // Campo para nota do filme
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Nota'),
              keyboardType: TextInputType.number,
            ),
            // Campo para descrição da avaliação
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3, // Permite mais de uma linha para descrição
            ),
            SizedBox(height: 20),
            // Botão de salvar ou atualizar
            ElevatedButton(
              onPressed: saveReview,
              child: Text(widget.reviewData == null ? 'Salvar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
