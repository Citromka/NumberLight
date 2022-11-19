import 'package:injectable/injectable.dart';
import 'package:numbers_light/data/network/network_datasource.dart';
import 'package:numbers_light/domain/model/base/domain_response.dart';

abstract class GetDetailUseCase {
  Future<DomainResponse> execute(String name);
}

@Injectable(as: GetDetailUseCase)
class GetDetailUseCaseImpl implements GetDetailUseCase {
  final NetworkDataSource _networkDataSource;

  GetDetailUseCaseImpl(this._networkDataSource);

  @override
  Future<DomainResponse> execute(String name) async {
    final response = await _networkDataSource.getNumberLightDetails(name);
    return DomainResponse.fromNetworkResponse(response);
  }
}