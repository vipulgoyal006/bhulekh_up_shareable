import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bhulekh_up/data_models/rest_error.dart';
import 'package:bhulekh_up/utils/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

enum RequestMethod { get, create, patch, remove }

class ApiCall {
  static Future<Response<T>> _generalApiCall<T>(
      String path, RequestMethod requestMethod,
      {String id = '',
      String basePath = 'https://upbhulekh.gov.in/',
      Map<String, dynamic> query = const {},
      dynamic body = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    Dio _dio = Dio();

    if (isAuthNeeded && SharedPreferenceHelper.accessToken != null) {
      _dio.options.headers['Authorization'] =
          SharedPreferenceHelper.accessToken;
    }
    try {
      log('URL $requestMethod $basePath/$path/$id QUERY: $query BODY: ${jsonEncode(body)} ${SharedPreferenceHelper.accessToken}');

      Response<T> response;
      switch (requestMethod) {
        case RequestMethod.get:
          response =
              await _dio.get<T>('$basePath/$path/$id', queryParameters: query);
          break;
        case RequestMethod.create:
          response = await _dio.post<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.patch:
          response = await _dio.patch<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.remove:
          response = await _dio.delete<T>('$basePath/$path/$id',
              queryParameters: query, options: extraOptions);
          break;
        default:
          throw ArgumentError('Invalid RequestMethod $requestMethod');
      }
      return response;
    } on SocketException {
      throw NoInternetError();
    } catch (error, s) {
      log('ERROR URL $basePath/$path/$id ${_dio.options.headers['Authorization']} ${jsonEncode(body)}',
          error: '$error', stackTrace: s);
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response?.statusCode == 502) {
          throw 'Server unreachable';
        } else if (error.response?.statusCode == 500) {
          log("ERROR ${error.response!.data}");
          throw 'Some error occurred.';
        } else {
          final restError = RestError.fromJson(error.response!.data);

          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  static Future<Response<T>> get<T>(String path,
      {String id = '',
      String basePath = 'https://upbhulekh.gov.in/',
      Map<String, dynamic> query = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.get,
        id: id, basePath: basePath, query: query, isAuthNeeded: isAuthNeeded);
  }

  static Future<Response<T>> post<T>(String path,
      {String id = '',
      String basePath = 'https://upbhulekh.gov.in/',
      Map<String, dynamic> query = const {},
      dynamic body = const {},
      bool isAuthNeeded = true,
      Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.create,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body,
        extraOptions: extraOptions);
  }
}
