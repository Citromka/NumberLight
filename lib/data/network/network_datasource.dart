import 'dart:convert';

import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:numbers_light/data/network/base/network_response.dart';
import 'package:numbers_light/data/network/model/number_light_api_model.dart';
import 'package:numbers_light/data/network/model/number_light_detail_api_model.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/domain/model/number_light_detail.dart';

abstract class NetworkDataSource {
  Future<NetworkResponse> getNumberLightList();

  Future<NetworkResponse> getNumberLightDetails(String name);
}

@Singleton(as: NetworkDataSource)
class NetworkDataSourceImpl implements NetworkDataSource {
  final Dio _dio;
  final _options = Options(responseType: ResponseType.json);

  NetworkDataSourceImpl() : _dio = Dio() {
    _dio.interceptors.add(
      DioLoggingInterceptor(
          level: Level.body,
          compact: false,
          logPrint: (o) {
            debugPrint("$o");
          }),
    );
  }

  @override
  Future<NetworkResponse> getNumberLightList() async {
    try {
      final response = await _dio.get(
        _listUrl,
        options: _options,
      );
      final decoded = json.decode(response.data);
      return NetworkResult(decoded.map(
          (e) => NumberLight.fromApiModel(NumberLightApiModel.fromJson(e))).toList());
    } on DioError catch (e) {
      return NetworkError(e.toErrorType());
    } catch (e) {
      return NetworkError(ErrorType.other);
    }
  }

  @override
  Future<NetworkResponse> getNumberLightDetails(String name) async {
    try {
      final queryParams = {
        'name': name,
      };
      final uri = Uri.http(_host, _path, queryParams);
      final response = await _dio.getUri(uri);
      if (response.data == null) {
        return NetworkResult(null);
      } else {
        final decoded = json.decode(response.data);
        return NetworkResult(NumberLightDetail.fromApiModel(NumberLightDetailApiModel.fromJson(decoded)));
      }
    } on DioError catch (e) {
      return NetworkError(e.toErrorType());
    } catch (e) {
      return NetworkError(ErrorType.other);
    }
  }

  static const _host = "dev.tapptic.com";
  static const _path = "test/json.php";
  static const _listUrl = "http://dev.tapptic.com/test/json.php";
}

extension on DioError {
  ErrorType toErrorType() {
    switch (type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return ErrorType.timedOut;
      case DioErrorType.response:
        final statusCode = response?.statusCode;
        if (statusCode == null) return ErrorType.other;
        if (statusCode >= 500) {
          return ErrorType.serverError;
        } else if (statusCode >= 400) {
          return ErrorType.clientError;
        } else {
          return ErrorType.other;
        }
      case DioErrorType.cancel:
        return ErrorType.cancelled;
      case DioErrorType.other:
        return ErrorType.other;
    }
  }
}
