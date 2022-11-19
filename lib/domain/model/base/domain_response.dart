import 'package:numbers_light/data/network/base/network_response.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';

abstract class DomainResponse {
  DomainResponse();

  factory DomainResponse.fromNetworkResponse(NetworkResponse response) {
    if (response is NetworkResult) {
      return DomainResult(response.data);
    } else if (response is NetworkError) {
      return DomainError(response.errorType);
    } else {
      throw Exception("Either NetworkResult or NetworkError should be returned from the network layer!");
    }
  }
}

class DomainResult<T> extends DomainResponse {
  final T data;

  DomainResult(this.data);
}

class DomainError extends DomainResponse {
  final ErrorType errorType;

  DomainError(this.errorType);
}