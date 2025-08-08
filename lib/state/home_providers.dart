import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/dio_client.dart';
import '../data/omdb_api.dart';
import '../data/repo/movie_repo.dart';
import '../data/models/movie_summary.dart';

final dioProvider = Provider((_) => makeDio());
final apiProvider = Provider((ref) => OmdbApi(ref.watch(dioProvider)));
final repoProvider = Provider((ref) => MovieRepo(ref.watch(apiProvider)));

final carouselProvider = FutureProvider<List<MovieSummary>>((ref) async {
  final repo = ref.watch(repoProvider);
  final (list, _) = await repo.search('popular', page: 1);
  return list.take(5).toList();
});

final batmanProvider = FutureProvider<List<MovieSummary>>((ref) async {
  final repo = ref.watch(repoProvider);
  final (list, _) = await repo.search('Batman', page: 1);
  return list;
});

final latest2022Provider = FutureProvider<List<MovieSummary>>((ref) async {
  final repo = ref.watch(repoProvider);
  final (list, _) = await repo.search('movie', page: 1, year: '2022');
  return list;
});
