import 'package:injectable/injectable.dart';
import 'package:numbers_light/data/network/network_datasource.dart';
import 'package:numbers_light/domain/model/base/domain_response.dart';

abstract class GetListUseCase {
  Future<DomainResponse> execute();
}

@Injectable(as: GetListUseCase)
class GetListUseCaseImpl implements GetListUseCase {
  final NetworkDataSource _networkDataSource;

  GetListUseCaseImpl(this._networkDataSource);

  @override
  Future<DomainResponse> execute() async {
    final response = await _networkDataSource.getNumberLightList();
    return DomainResponse.fromNetworkResponse(response);
  }
}