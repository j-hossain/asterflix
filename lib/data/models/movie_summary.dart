class MovieSummary {
  final String imdbID;
  final String title;
  final String year;
  final String poster;
  final String type;

  MovieSummary({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
    required this.type,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> j) => MovieSummary(
        imdbID: j['imdbID'] ?? '',
        title: j['Title'] ?? '',
        year: j['Year'] ?? '',
        poster: j['Poster'] ?? '',
        type: j['Type'] ?? '',
      );
}
