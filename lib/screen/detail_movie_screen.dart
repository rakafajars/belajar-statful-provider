import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/constant/api_url.dart';
import 'package:flutter_application_2/service/movie_service.dart';

class DetailMovieScreen extends StatefulWidget {
  final String movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Movie'),
      ),
      body: FutureBuilder(
        future: MovieService().getDetailMovie(
          widget.movieId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var detailMovie = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    "$urlImage/${detailMovie?.posterPath ?? "-"}",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(detailMovie?.title ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(detailMovie?.overview ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      detailMovie?.originalLanguage.toUpperCase() ?? "",
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            Text(
              snapshot.error.toString(),
            );
          }
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
