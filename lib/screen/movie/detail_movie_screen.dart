import 'package:flutter/material.dart';
import 'package:flutter_application_2/constant/api_url.dart';
import 'package:flutter_application_2/db/database_helper.dart';
import 'package:flutter_application_2/model/api/movie_api.dart';
import 'package:flutter_application_2/model/watchlist_movie_table.dart';
import 'package:flutter_application_2/screen/movie/detail_movie_view_model.dart';
import 'package:provider/provider.dart';

class DetailMovieScreen extends StatefulWidget {
  final String movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  void initState() {
    final detailMoviewViewModel =
        Provider.of<DetailMoviewViewModel>(context, listen: false);
    detailMoviewViewModel.getDetailMovie(widget.movieId);
    detailMoviewViewModel.getWatchlistStatus(widget.movieId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailMoviewViewModel =
        Provider.of<DetailMoviewViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Movie'),
      ),
      body: detailMoviewViewModel.isLoadingDetailMovie
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    "$urlImage/${detailMoviewViewModel.detailMovieResponse.posterPath}",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (detailMoviewViewModel.isInserWatchMovie == true) {
                            detailMoviewViewModel.removeWatchList();
                          } else {
                            detailMoviewViewModel.insertWatchlist();
                          }
                        },
                        icon: detailMoviewViewModel.isInserWatchMovie == true
                            ? const Icon(Icons.delete)
                            : const Icon(
                                Icons.add,
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        detailMoviewViewModel.detailMovieResponse.title ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        detailMoviewViewModel.detailMovieResponse.overview ??
                            ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      detailMoviewViewModel.detailMovieResponse.originalLanguage
                              ?.toUpperCase() ??
                          "",
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
