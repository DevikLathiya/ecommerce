import 'package:hindustane_ecommerce/config/config.dart';
import 'package:hindustane_ecommerce/network/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: URLs.API_URL,
      connectTimeout: AppLimit.REQUEST_TIME_OUT,
      receiveTimeout: AppLimit.REQUEST_TIME_OUT,
      sendTimeout: AppLimit.REQUEST_TIME_OUT,
    );

    var dio = Dio(options);

    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }

  @override
  void dependencies() {
    Get.lazyPut(
      _dio,
    );
  }
}
