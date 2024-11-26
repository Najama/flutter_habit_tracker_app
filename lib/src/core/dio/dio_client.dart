import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_constants.dart';


class DioClient {
  final Dio _dio = Dio();
  final List<Interceptor>? interceptors;
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Timeout Error';
      case DioExceptionType.badResponse:
        final statusCode = error.response!.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 300:
              return 'error';
            case 400:
              return 'Bad Request';
            case 404:
              return 'not found';
            case 500:
              return 'internal server error';
          }
        }
        break;
      case DioExceptionType.unknown:
        return 'No Internet Connection';
      case DioExceptionType.badCertificate:
        return 'Bad Certificate Error';
      case DioExceptionType.connectionError:
        return 'Connection Error';

      case DioExceptionType.cancel:
        return 'Cancelled by user';
    }
    return 'unknown Error';
  }

  DioClient(this.interceptors) {
    _dio
      ..options.baseUrl = ApiConstants.BaseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.headers = {'Content-Type': 'application/json'}
      ..options.validateStatus = (status) {
        return status != null && status < 500;
      };
    if (interceptors != null && interceptors!.isNotEmpty) {
      _dio.interceptors.addAll(interceptors!);
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
        ),
      );
    }
  }
    Future<Response> get(String path,
        {Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken}) async {
      try {
        final response = await _dio.get(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken);
        return response;
      } on SocketException catch (e) {
        throw SocketException(e.toString());
      } on DioException catch (e) {
        throw _handleDioError(e);
      }
    }

    Future<Response> post(String path,
        {dynamic data, Options? options, CancelToken? cancelToken}) async {
      try {
        final response = await _dio.post(path,
            data: data, options: options, cancelToken: cancelToken);
        return response;
      } on SocketException catch (e) {
        throw SocketException(e.toString());
      } on DioException catch (e) {
        throw _handleDioError(e);
      }
    }

  


  

}
final dioProvider =  Provider<DioClient>((ref)=>DioClient([]));
