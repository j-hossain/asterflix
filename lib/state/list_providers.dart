import 'package:asterflix/data/repo/movie_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/movie_summary.dart';
import 'home_providers.dart';

class PagedState {
  final List<MovieSummary> items;
  final int total;
  final int page;
  final bool loading;
  PagedState({
    required this.items,
    required this.total,
    required this.page,
    required this.loading,
  });

  PagedState copyWith({
    List<MovieSummary>? items,
    int? total,
    int? page,
    bool? loading,
  }) =>
      PagedState(
        items: items ?? this.items,
        total: total ?? this.total,
        page: page ?? this.page,
        loading: loading ?? this.loading,
      );
}

final queryProvider = StateProvider<String>((_) => 'marvel');
final yearFilterProvider = StateProvider<String?>((_) => null); // <— new

final pagedProvider = StateNotifierProvider.family<PagedNotifier, PagedState, (String q, String? y)>((ref, args) {
  final repo = ref.watch(repoProvider);
  final notifier = PagedNotifier(repo, args.$1, args.$2);
  // kick off after microtask so constructor stays sync
  Future.microtask(() => notifier.load());
  return notifier;
});

class PagedNotifier extends StateNotifier<PagedState> {
  final MovieRepo repo;
  final String query;
  final String? year;
  PagedNotifier(this.repo, this.query, this.year)
      : super(PagedState(items: [], total: 0, page: 0, loading: false));

  Future<void> load() async {
    if (state.loading) return;
    final next = state.page + 1;
    state = state.copyWith(loading: true);
    final (list, total) = await repo.search(query, page: next, year: year);
    state = PagedState(
      items: [...state.items, ...list],
      total: total,
      page: next,
      loading: false,
    );
  }
}


