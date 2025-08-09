import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/list_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class ListScreen extends ConsumerStatefulWidget {
  final String initialQuery;
  final String? year;
  final String screenTitle;
  const ListScreen({super.key, this.initialQuery = 'marvel', this.year, this.screenTitle = 'Listing'});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 400) {
        ref.read(pagedProvider((widget.initialQuery, widget.year)).notifier).load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pagedProvider((widget.initialQuery, widget.year)));
    return Scaffold(
      appBar: AppBar(title: Text(widget.screenTitle)),
      body: ListView.separated(
        controller: controller,
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          if (i >= state.items.length) {
            return state.loading
                ? const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
                : const SizedBox();
          }
          final m = state.items[i];
          return ListTile(
            onTap: () => context.push('/detail/${m.imdbID}'),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(imageUrl: m.poster, width: 54, height: 80, fit: BoxFit.cover),
            ),
            title: Text(m.title),
            subtitle: Text('${m.year} • ${m.type}'),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: state.items.length + 1,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}


