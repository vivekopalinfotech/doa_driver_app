// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:doa_driver_app/api/login_interceptors.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';
import 'package:doa_driver_app/api/responses/logout_response.dart';
import 'package:doa_driver_app/api/responses/mobile_rsponse.dart';
import 'package:doa_driver_app/api/responses/order_response.dart';
import 'package:doa_driver_app/constants/app_config.dart';
import 'package:doa_driver_app/constants/app_data.dart';

class ApiProvider {
  final String _baseUrl = "${AppConfig.ECOMMERCE_URL}/api/client/";

  static String imgThumbnailUrlString =
      "${AppConfig.ECOMMERCE_URL}/gallary/thumbnail";
  static String imgMediumUrlString =
      "${AppConfig.ECOMMERCE_URL}/gallary/medium";
  static String imgLargeUrlString =
      "${AppConfig.ECOMMERCE_URL}/gallary/large";

  Dio? _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        validateStatus: (status) => true,
        followRedirects: false);
    _dio = Dio(options);
    _dio?.options.headers.addAll({
      'clientid': AppConfig.CONSUMER_KEY,
      'clientsecret': AppConfig.CONSUMER_SECRET,
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'authorization': AppData.accessToken == null
          ? ""
          : 'Bearer ${AppData.accessToken}',
    });
    _dio?.interceptors.add(LoggingInterceptor());
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_login",
          data: jsonEncode({
            "email": email,
            "password": password,
            "session_id": AppData.sessionId
          }));
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_logout");
      print(response);
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<MobileResponse> phoneNo(String phoneNumber) async {
    try {
      Response response = await _dio!.post("${_baseUrl}verifydelivery_mobile",
          data: jsonEncode({
            "phone_number": phoneNumber,
          }));
      return MobileResponse.fromJson(response.data);
    } catch (error) {
      return MobileResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> otp(String phoneNumber,String otp) async {
    try {
      Response response = await _dio!.post("${_baseUrl}deliverylogin",
          data: jsonEncode({
            "phone_number": phoneNumber,
            "mobile_del_code": otp,
          }));
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }


  Future<String> online(String id,String availabilityStatus) async {
    try {
      Response response = await _dio!.put("${_baseUrl}update_delivery_boy_status",
          data: jsonEncode({
            "id": id,
            "availability_status": availabilityStatus,
          }));
      return response.data;
    } catch (error) {
      return error.toString();
    }
  }

  Future<OrderResponse> getOrder() async {
    try {
      Response response = await _dio!.get("${_baseUrl}order?delivery_boy_id=2&productDetail=1&pending_orders=1");
      log(jsonEncode(response.data));
      return OrderResponse.fromJson(response.data);
    } catch (error) {
      return OrderResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrderResponse> getHistory() async {
    try {
      Response response = await _dio!.get("${_baseUrl}order?delivery_boy_id=2&productDetail=1&complete_orders=1");
      log(jsonEncode(response.data));
      return OrderResponse.fromJson(response.data);
    } catch (error) {
      return OrderResponse.withError(_handleError(error as TypeError));
    }
  }


  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
          "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.other:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = error.toString();
      print(error);
      print(error.stackTrace);
    }
    return errorDescription;
  }
}