import 'package:flutter/material.dart';
import 'package:flutter_application_2/constant/api_url.dart';
import 'package:flutter_application_2/db/database_helper.dart';
import 'package:flutter_application_2/model/watchlist_movie_table.dart';
import 'package:flutter_application_2/service/movie_service.dart';

class DetailMovieScreen extends StatefulWidget {
  final String movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool _isInsert = false;

  WatchlistMovieTable? _watchlistMovieTable = WatchlistMovieTable(
    id: -1,
    title: "",
    postPath: "",
  );

  void getWatchlistStatus() async {
    _watchlistMovieTable = await DatabaseHelper().getStatusWatchlist(
      int.parse(
        widget.movieId,
      ),
    );
    if (_watchlistMovieTable != null) {
      _isInsert = true;
    }
  }

  @override
  void initState() {
    getWatchlistStatus();
    super.initState();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (_isInsert == true) {
                            _isInsert = false;
                            DatabaseHelper().removeWatchlist(
                              detailMovie?.id ?? -1,
                            );
                          } else {
                            _isInsert = true;
                            DatabaseHelper().insertWatchlist(
                              WatchlistMovieTable(
                                id: detailMovie?.id ?? -1,
                                title: detailMovie?.title ?? "",
                                postPath: detailMovie?.posterPath ?? "",
                              ),
                            );
                          }
                          setState(() {});
                        },
                        icon: _isInsert == true
                            ? const Icon(Icons.delete)
                            : const Icon(
                                Icons.add,
                              ),
                      ),
                    ],
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
