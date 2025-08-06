import '../models/movie_detail.dart';
import '../models/movie_summary.dart';
import '../omdb_api.dart';

class MovieRepo {
  final OmdbApi api;

  MovieRepo(this.api);

  Future<(List<MovieSummary>, int total)> search(String q,
      {int page = 1, String? year}) async {
    final j = await api.search(query: q, page: page, year: year);
    final list = (j['Search'] as List? ?? [])
        .map((e) => MovieSummary.fromJson(e))
        .toList();
    final total = int.tryParse(j['totalResults'] ?? '0') ?? 0;
    return (list, total);
  }

  Future<MovieDetail> detail(String imdbId) async {
    final j = await api.byId(imdbId);
    return MovieDetail.fromJson(j);
  }
}
