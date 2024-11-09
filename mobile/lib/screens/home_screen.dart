import 'package:flutter/material.dart';
import 'package:mobile/service/movie_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService movieService = MovieService();
  late Future<List<dynamic>> movies;

  @override
  void initState() {
    super.initState();
    movies = movieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filmes Populares')),
      body: FutureBuilder<List<dynamic>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Exibir 4 filmes por linha
                childAspectRatio:
                    0.6, // Ajustar a proporção de cada item para imagens de pôster
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        movie['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Avaliar'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Avaliações'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/add_review');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/reviews');
          }
        },
      ),
    );
  }
}
