import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../core/env.dart';
import '../../state/playback_store.dart';

class PlayerFrame extends ConsumerStatefulWidget {
  final String imdbId;
  final String title;
  final String? src;
  const PlayerFrame({super.key, required this.imdbId, required this.title, this.src});

  @override
  ConsumerState<PlayerFrame> createState() => _InlinePlayerState();
}

class _InlinePlayerState extends ConsumerState<PlayerFrame> {
  late VideoPlayerController _video;
  ChewieController? _chewie;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    final store = ref.read(playbackStoreProvider);
    final startAt = store.getPosition(widget.imdbId);
    final url = widget.src ?? Env.sampleStream;
    _video = VideoPlayerController.networkUrl(Uri.parse(url));
    _video.initialize().then((_) async {
      final dur = _video.value.duration;
      if (startAt > Duration.zero && (dur == null || startAt < dur)) {
        await _video.seekTo(startAt);
      }
      if (mounted) {
        setState(() {
          _chewie = ChewieController(videoPlayerController: _video, autoPlay: false, looping: false);
          _ready = true;
        });
      }
    });
  }

  @override
  void dispose() {
    final store = ref.read(playbackStoreProvider);
    final pos = _video.value.isInitialized ? _video.value.position : Duration.zero;
    store.savePosition(widget.imdbId, pos);
    _chewie?.dispose();
    _video.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _video.value.isInitialized && _video.value.aspectRatio != 0
          ? _video.value.aspectRatio
          : 16 / 9,
      child: _ready && _chewie != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Chewie(controller: _chewie!),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
