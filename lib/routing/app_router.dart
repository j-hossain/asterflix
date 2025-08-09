import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/list/list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/list',
      builder: (_, s) {
        final q = s.uri.queryParameters['q'] ?? 'marvel';
        final year = s.uri.queryParameters['year'];
        final title = s.uri.queryParameters['title'] ?? 'Listing: $q';
        return ListScreen(initialQuery: q, year: year, screenTitle: title);
      },
    ),
  ],
);
