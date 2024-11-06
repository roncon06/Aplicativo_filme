// lib/screens/listagem_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/filme.dart';

class ListagemScreen extends StatefulWidget {
  @override
  _ListagemScreenState createState() => _ListagemScreenState();
}

class _ListagemScreenState extends State<ListagemScreen> {
  List<Filme> _filmes = [];

  @override
  void initState() {
    super.initState();
    fetchFilmes();
  }

  // Função para buscar os filmes de uma API
  Future<void> fetchFilmes() async {
    final response = await http.get(Uri.parse('http://localhost:3000/movies'));

    if (response.statusCode == 200) {
      final List<dynamic> filmesJson = json.decode(response.body);
      setState(() {
        _filmes = filmesJson.map((json) => Filme.fromJson(json)).toList();
      });
    } else {
      throw Exception('Falha ao carregar filmes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Filmes'),
      ),
      body: _filmes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _filmes.length,
              itemBuilder: (context, index) {
                final filme = _filmes[index];
                return ListTile(
                  title: Text(filme.titulo),
                  subtitle: Text(filme.diretor),
                  trailing: Text('R\$${filme.preco.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
