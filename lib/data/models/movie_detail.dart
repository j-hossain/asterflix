class MovieDetail {
  final String imdbID;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String imdbRating;

  MovieDetail({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.imdbRating,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> j) => MovieDetail(
        imdbID: j['imdbID'] ?? '',
        title: j['Title'] ?? '',
        year: j['Year'] ?? '',
        rated: j['Rated'] ?? '',
        released: j['Released'] ?? '',
        runtime: j['Runtime'] ?? '',
        genre: j['Genre'] ?? '',
        director: j['Director'] ?? '',
        writer: j['Writer'] ?? '',
        actors: j['Actors'] ?? '',
        plot: j['Plot'] ?? '',
        language: j['Language'] ?? '',
        country: j['Country'] ?? '',
        awards: j['Awards'] ?? '',
        poster: j['Poster'] ?? '',
        imdbRating: j['imdbRating'] ?? '',
      );
}
