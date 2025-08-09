import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final playbackStoreProvider =
    Provider<PlaybackStore>((_) => throw UnimplementedError());

class PlaybackStore {
  final Box box;
  PlaybackStore(this.box);

  Duration getPosition(String id) {
    final ms = box.get(id, defaultValue: 0) as int;
    return Duration(milliseconds: ms);
  }

  Future<void> savePosition(String id, Duration pos) async {
    await box.put(id, pos.inMilliseconds);
  }
}
