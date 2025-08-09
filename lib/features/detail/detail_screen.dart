import 'package:asterflix/core/env.dart';
import 'package:asterflix/features/detail/player_frame.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/detail_providers.dart';

class DetailScreen extends ConsumerWidget {
  final String imdbId;

  const DetailScreen({super.key, required this.imdbId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(detailProvider(imdbId));
    return Scaffold(
      appBar: AppBar(),
      body: d.when(
        data: (m) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PlayerFrame(
              imdbId: m.imdbID,
              title: m.title,
              src: Env.sampleStream,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                      imageUrl: m.poster,
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('${m.year} • ${m.runtime} • ⭐ ${m.imdbRating}'),
                      const SizedBox(height: 8),
                      Text(m.genre),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Plot', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(m.plot.isEmpty || m.plot == 'N/A'
                ? 'No plot available.'
                : m.plot),
            const SizedBox(height: 16),
            Text('Cast', style: Theme.of(context).textTheme.titleMedium),
            Text(m.actors),
            const SizedBox(height: 12),
            Text('Director: ${m.director}'),
            Text('Writer: ${m.writer}'),
            Text('Language: ${m.language}'),
            Text('Country: ${m.country}'),
            if (m.awards.isNotEmpty) Text('Awards: ${m.awards}'),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
