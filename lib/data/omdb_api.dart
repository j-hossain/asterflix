import 'package:dio/dio.dart';
import '../core/env.dart';
import '../core/types.dart';

class OmdbApi {
  final Dio dio;
  OmdbApi(this.dio);

  Future<Json> search({
    required String query,
    int page = 1,
    String? year,
    String type = 'movie',
  }) async {
    final resp = await dio.get('', queryParameters: {
      'apikey': Env.omdbKey,
      's': query,
      'type': type,
      'page': page,
      if (year != null) 'y': year,
    });
    return resp.data as Json;
  }

  Future<Json> byId(String imdbId) async {
    final resp = await dio.get('', queryParameters: {
      'apikey': Env.omdbKey,
      'i': imdbId,
      'plot': 'full',
    });
    return resp.data as Json;
  }
}
