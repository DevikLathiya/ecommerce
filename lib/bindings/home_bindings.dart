import 'package:hindustane_ecommerce/config/config.dart';
import 'package:hindustane_ecommerce/controller/address_book_controller.dart';
// import 'package:amazy_app/controller/address_book_controller.dart';
import 'package:hindustane_ecommerce/controller/home_controller.dart';
import 'package:hindustane_ecommerce/network/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
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
    Get.lazyPut(() => BaseOptions());
    // Get.lazyPut(() => ProductDetailsController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AddressController());
  }
}
