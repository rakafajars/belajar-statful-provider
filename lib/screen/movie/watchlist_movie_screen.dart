import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/database_helper.dart';

class WatchListMovieScreen extends StatefulWidget {
  const WatchListMovieScreen({super.key});

  @override
  State<WatchListMovieScreen> createState() => _WatchListMovieScreenState();
}

class _WatchListMovieScreenState extends State<WatchListMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: FutureBuilder(
        future: DatabaseHelper().getListWatchlistMovie(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return data?.isEmpty == true
                ? const Center(child: Text('Kosong'))
                : ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data?[index].title ?? "",
                        ),
                      );
                    },
                  );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
