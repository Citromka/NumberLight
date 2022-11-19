import 'package:numbers_light/domain/model/base/error_type.dart';

abstract class NetworkResponse {}

class NetworkResult<T> implements NetworkResponse {
  final T data;

  NetworkResult(this.data);
}

class NetworkError implements NetworkResponse {
  final ErrorType errorType;

  NetworkError(this.errorType);
}