import 'package:flutter/material.dart';
import 'package:flutter_application_2/constant/api_url.dart';
import 'package:flutter_application_2/screen/movie/detail_movie_screen.dart';
import 'package:flutter_application_2/screen/movie/list_movie_view_model.dart';
import 'package:flutter_application_2/screen/movie/watchlist_movie_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ListMovieScreen extends StatefulWidget {
  const ListMovieScreen({super.key});

  @override
  State<ListMovieScreen> createState() => _ListMovieScreenState();
}

class _ListMovieScreenState extends State<ListMovieScreen> {
  @override
  void initState() {
    final movieViewModel =
        Provider.of<ListMovieViewModel>(context, listen: false);
    movieViewModel.getListMoviePopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieViewModel = Provider.of<ListMovieViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WatchListMovieScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.movie,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Movie Popular',
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: movieViewModel.isLoadingListMovie == true
                        ? const CircularProgressIndicator()
                        : movieViewModel.isResultMovieEmpty
                            ? const Text("Data Kosong")
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movieViewModel.listMovie.length,
                                itemBuilder: (context, index) {
                                  final movie = movieViewModel.listMovie[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailMovieScreen(
                                            movieId: movie.id.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width: 250,
                                      height: 100,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Image.network(
                                                "$urlImage/${movie.posterPath}",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Text(
                                              movie.originalTitle,
                                            ),
                                            RatingBarIndicator(
                                              itemSize: 20,
                                              rating: (movie.voteAverage / 2),
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 4.0,
                                              ),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 4,
                                              ),
                                            ),
                                            Text(
                                              movie.originalLanguage
                                                      ?.toUpperCase() ??
                                                  "-",
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body(ListMovieViewModel listMovieViewModel) {
    final isLoading = listMovieViewModel.state == ListViewMovieState.loading;
    final isError = listMovieViewModel.state == ListViewMovieState.error;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError) {
      return const Center(
        child: Text('Gagal Mengambil Data'),
      );
    }

    return const Center(
      child: Text(
        "berhasil mengambil data",
      ),
    );
  }
}
