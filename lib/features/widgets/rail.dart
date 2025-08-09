import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/movie_summary.dart';

class PortraitRail extends StatelessWidget {
  final String title;
  final List<MovieSummary> items;
  final VoidCallback? onSeeAll; // <— new
  const PortraitRail({super.key, required this.title, required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
            IconButton(
              onPressed: onSeeAll, // <— new
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              tooltip: 'See all',
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final m = items[i];
              return InkWell(
                onTap: () => context.push('/detail/${m.imdbID}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(imageUrl: m.poster, width: 120, height: 170, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(width: 120, child: Text(m.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}

