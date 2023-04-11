class WatchlistMovieTable {
  final int id;
  final String title;
  final String postPath;

  WatchlistMovieTable({
    required this.id,
    required this.title,
    required this.postPath,
  });

  factory WatchlistMovieTable.fromMap(Map<String, dynamic> map) =>
      WatchlistMovieTable(
        id: map["id"],
        title: map["title"],
        postPath: map["postPath"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "postPath": postPath,
      };
}
