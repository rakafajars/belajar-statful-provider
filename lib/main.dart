import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/movie/detail_movie_view_model.dart';
import 'package:flutter_application_2/screen/movie/list_movie_view_model.dart';
import 'package:flutter_application_2/screen/movie/new_list_movie_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ListMovieViewModel>(
          create: (_) => ListMovieViewModel(),
        ),
        ChangeNotifierProvider<DetailMoviewViewModel>(
          create: (_) => DetailMoviewViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewListMovieScreen(),
    );
  }
}
