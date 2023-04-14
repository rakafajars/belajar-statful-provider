import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/api/movie_api.dart';

import '../../model/list_movie_popular_response.dart';

enum ListViewMovieState {
  none, // idle
  loading, // running
  error, // error
  empty,
}

class ListMovieViewModel with ChangeNotifier {
  // LOGIC LIST MOVIE
  List<ResultMovie> _listMovie = [];
  List<ResultMovie> get listMovie => _listMovie;
  bool _isResultMovieEmpty = false;
  bool get isResultMovieEmpty => _isResultMovieEmpty;
  // 1. Bikin Property isLoadingListMovie dengan nilai default false
  bool _isLoadingListMovie = false;
  bool get isLoadingListMovie => _isLoadingListMovie;
  // END LOGIC LIST MOVIE

  ListViewMovieState _state = ListViewMovieState.none;
  ListViewMovieState get state => _state;

  changeState(ListViewMovieState s) {
    _state = s;
    notifyListeners();
  }

  getNewListMoviePopular() async {
    changeState(ListViewMovieState.loading);

    try {
      final result = await MovieApi().getListMoviePopular();
      notifyListeners();
      if (result.data.isNotEmpty) {
        _listMovie = result.data;

        changeState(ListViewMovieState.none);
      } else {
        _listMovie = [];
        changeState(ListViewMovieState.empty);
      }
    } catch (e) {
      changeState(ListViewMovieState.error);
    }
  }

  getListMoviePopular() async {
    // 2. Karna Kondisi Default False, Ubah Nilai isLoading
    // Menjadi True, supaya kondisi UI Menampilkan
    // Loading Widget
    _isLoadingListMovie = true;
    // print('1. $_isLoadingListMovie');
    // 3. Fungsi API Service akan dijalan getListMovie()
    // 4. ketika proses dijalan, secara itu ada proses loading untuk menampilkan DATA
    final result = await MovieApi().getListMoviePopular();
    // 5. result itu merupakan data dari hasil dari loading, akan menampilkan data dari sini
    if (result.data.isNotEmpty) {
      _listMovie = result.data;
    } else {
      _isResultMovieEmpty = true;
    }
    // 4. Ketika Datar Berhasil diambil/Gagal kondisi is Loadingnya menjadi false
    _isLoadingListMovie = false;
    notifyListeners();
  }
}
