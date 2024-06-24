// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:doa_driver_app/api/login_interceptors.dart';
import 'package:doa_driver_app/api/responses/delivery_status_response.dart';
import 'package:doa_driver_app/api/responses/delivery_update_response.dart';
import 'package:doa_driver_app/api/responses/login_response.dart';
import 'package:doa_driver_app/api/responses/logout_response.dart';
import 'package:doa_driver_app/api/responses/mobile_rsponse.dart';
import 'package:doa_driver_app/api/responses/order_response.dart';
import 'package:doa_driver_app/api/responses/shifts_data_response.dart';
import 'package:doa_driver_app/constants/app_config.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:intl/intl.dart';

class ApiProvider {
  final String _baseUrl = "${AppConfig.ECOMMERCE_URL}/api/client/";

  static String imgThumbnailUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/thumbnail";
  static String imgMediumUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/medium";
  static String imgLargeUrlString = "${AppConfig.ECOMMERCE_URL}/gallary/large";

  Dio? _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000, validateStatus: (status) => true, followRedirects: false);
    _dio = Dio(options);
    _dio?.options.headers.addAll({
      'clientid': AppConfig.CONSUMER_KEY,
      'clientsecret': AppConfig.CONSUMER_SECRET,
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'authorization': AppData.accessToken == null ? "" : 'Bearer ${AppData.accessToken}',
    });
    print(_dio?.options.headers);
    print(AppData.accessToken);
    _dio?.interceptors.add(LoggingInterceptor());
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_login", data: jsonEncode({"email": email, "password": password, "session_id": AppData.sessionId}));
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio!.post("${_baseUrl}customer_logout");
      print(response);
      log(jsonEncode(response.data));
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> updateProfile(String id, String vehicleNo, String vehicleColor, String firstName, String lastName, String code) async {
    try {
      Response response = await _dio!.post("${_baseUrl}deliveryboy_update/$id",
          data: jsonEncode({
            "vehicle_registration_no": vehicleNo,
            "vehicle_color": vehicleColor,
            "first_name": firstName,
            "last_name": lastName,
            "mobile_del_code": code,
          }));
      log(jsonEncode(response.data));
      print(response);
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<String> updateLatLong(
    String id,
    String latLng,
  ) async {
    try {
      Response response = await _dio!.post("${_baseUrl}deliveryboy_latlong/$id",
          data: jsonEncode({
            "latlong": latLng,
          }));
      log(jsonEncode(response.data));
      print(response);
      return response.data;
    } catch (error) {
      return 'Error';
    }
  }

  Future<MobileResponse> phoneNo(String phoneNumber) async {
    try {
      Response response = await _dio!.post("${_baseUrl}verifydelivery_mobile",
          data: jsonEncode({
            "phone_number": phoneNumber,
          }));
      log(jsonEncode(response.data));
      return MobileResponse.fromJson(response.data);
    } catch (error) {
      return MobileResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> otp(String phoneNumber, String otp) async {
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

  online(String id, String availabilityStatus) async {
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

  Future<DeliveryStatusResponse> checkOrderStatus(String id, String orderStatus, double paid_cash, double paid_cc_terminal) async {
    try {
      Response response = await _dio!.put("${_baseUrl}delivery_status_by_delivery_boy/$id",
          data: jsonEncode({
            "delivery_status": orderStatus,
            "paid_cash": paid_cash,
            "paid_cc_terminal": paid_cc_terminal,
          }));
      log(jsonEncode(response.data));
      return DeliveryStatusResponse.fromJson(response.data);
    } catch (error) {
      return DeliveryStatusResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrderResponse> getOrder(int id) async {
    try {
      Response response = await _dio!.get("${_baseUrl}order?delivery_boy_id=$id&productDetail=1&delivery_status=0");
      log(jsonEncode(response.data));
      return OrderResponse.fromJson(response.data);
    } catch (error) {
      return OrderResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<OrderResponse> getHistory(int id) async {
    try {
      Response response = await _dio!.get("${_baseUrl}order?delivery_boy_id=$id&productDetail=1&delivery_status=1");
      log(jsonEncode(response.data));
      return OrderResponse.fromJson(response.data);
    } catch (error) {
      return OrderResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<ShiftsDataResponse> getShiftsData(int id) async {
    try {
      Response response = await _dio!.post("${_baseUrl}driver_stats/$id");
      log(jsonEncode(response.data));
      return ShiftsDataResponse.fromJson(response.data);
    } catch (error) {
      return ShiftsDataResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<DeliveryUpdateResponse> getDeliveryUpdate(int id) async {
    try {
      Response response = await _dio!.get("${_baseUrl}delivery_update/$id");
      log(jsonEncode(response.data));
      return DeliveryUpdateResponse.fromJson(response.data);
    } catch (error) {
      return DeliveryUpdateResponse.withError(_handleError(error as TypeError));
    }
  }

  Future<LoginResponse> updateShift(int id, status, token) async {
    try {
      Response response = await _dio!.put("${_baseUrl}update_availability/$id", data: jsonEncode({"fcm_token": token, "shift_status": '$status', "availability_status": '$status'}));
      log(jsonEncode(response.data));
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error as TypeError));
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
          errorDescription = "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.other:
          errorDescription = "Connection to API server failed due to internet connection";
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
