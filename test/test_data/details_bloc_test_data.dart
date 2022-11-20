import 'package:numbers_light/domain/model/base/domain_response.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:numbers_light/domain/model/number_light_detail.dart';

class DetailsBlocTestData {
  static final DetailsBlocTestData instance = DetailsBlocTestData._internal();

  factory DetailsBlocTestData() {
    return instance;
  }

  DetailsBlocTestData._internal();

  final selectionDomainResult = DomainResult(const NumberLightDetail(
    id: "1",
    name: "1",
    text: "Test",
    image: "url",
  ));

  final selectionDomainError = DomainError(ErrorType.other);
}
