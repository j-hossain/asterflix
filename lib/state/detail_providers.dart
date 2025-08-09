import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/movie_detail.dart';
import 'home_providers.dart';

final detailProvider =
FutureProvider.family<MovieDetail, String>((ref, imdbId) async {
  final repo = ref.watch(repoProvider);
  return repo.detail(imdbId);
});
