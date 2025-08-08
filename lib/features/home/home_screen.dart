import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/home_providers.dart';
import '../widgets/carousel.dart';
import '../widgets/rail.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carousel = ref.watch(carouselProvider);
    final batman = ref.watch(batmanProvider);
    final latest = ref.watch(latest2022Provider);

    return Scaffold(
      appBar: AppBar(title: const Text('AsterFlix'), actions: [
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          carousel.maybeWhen(data: (d) => Carousel(items: d), orElse: () => const SizedBox(height: 180)),
          const SizedBox(height: 16),
          batman.maybeWhen(
            data: (d) => PortraitRail(
              title: 'Batman',
              items: d,
            ),
            orElse: () => const SizedBox(),
          ),
          const SizedBox(height: 16),
          latest.maybeWhen(
            data: (d) => PortraitRail(
              title: 'Latest (2022)',
              items: d,
            ),
            orElse: () => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
