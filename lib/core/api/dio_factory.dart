import 'package:dio/dio.dart';

import 'api_endpoints.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.mealDbBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
