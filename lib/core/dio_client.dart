import 'package:dio/dio.dart';
import 'env.dart';

Dio makeDio() {
  final dio = Dio(BaseOptions(
    baseUrl: Env.omdbBase,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
  ));
  dio.interceptors.add(LogInterceptor(responseBody: false, requestBody: false));
  return dio;
}
