import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/database_helper.dart';
import 'package:flutter_application_2/model/api/movie_api.dart';
import 'package:flutter_application_2/model/watchlist_movie_table.dart';

import '../../model/detail_movie_response.dart';

class DetailMoviewViewModel with ChangeNotifier {
  bool _isIsertWatchMovie = false;
  bool get isInserWatchMovie => _isIsertWatchMovie;

  WatchlistMovieTable? _watchlistMovieTable = WatchlistMovieTable();
  WatchlistMovieTable get watchlistMovieTable => _watchlistMovieTable!;

  void getWatchlistStatus(String movieId) async {
    _watchlistMovieTable = await DatabaseHelper().getStatusWatchlist(
      int.parse(
        movieId,
      ),
    );
    if (_watchlistMovieTable != null) {
      _isIsertWatchMovie = true;
    }
    notifyListeners();
  }

  // FUNGSI API YANG AKAN DITAMPILKAN DI UI
  DetailMovieResponse _detailMovieResponse = DetailMovieResponse();
  DetailMovieResponse get detailMovieResponse => _detailMovieResponse;
  bool _isLoadingDetailMovie = false;
  bool get isLoadingDetailMovie => _isLoadingDetailMovie;

  void getDetailMovie(String movieId) async {
    _isLoadingDetailMovie = true;
    _detailMovieResponse = await MovieApi().getDetailMovie(movieId);
    _isLoadingDetailMovie = false;
    notifyListeners();
  }
  // End Fungsi API yang akan ditampilkan

  void removeWatchList() async {
    _isIsertWatchMovie = false;
    await DatabaseHelper().removeWatchlist(
      detailMovieResponse.id ?? 1,
    );
    notifyListeners();
  }

  void insertWatchlist() async {
    _isIsertWatchMovie = true;
    await DatabaseHelper().insertWatchlist(
      WatchlistMovieTable(
        id: detailMovieResponse.id,
        title: detailMovieResponse.title,
        postPath: detailMovieResponse.posterPath,
      ),
    );
    notifyListeners();
  }
}
