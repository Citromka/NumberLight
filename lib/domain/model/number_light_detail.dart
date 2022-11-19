import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:numbers_light/data/network/model/number_light_detail_api_model.dart';
import 'package:uuid/uuid.dart';

part 'number_light_detail.freezed.dart';

part 'number_light_detail.g.dart';

@freezed
class NumberLightDetail with _$NumberLightDetail {
  const factory NumberLightDetail({
    required String id,
    required String name,
    required String text,
    required String image,
  }) = _NumberLightDetail;

  factory NumberLightDetail.fromJson(Map<String, Object?> json) =>
      _$NumberLightDetailFromJson(json);

  factory NumberLightDetail.fromApiModel(NumberLightDetailApiModel apiModel) {
    return NumberLightDetail(
      id: const Uuid().v4(),
      name: apiModel.name,
      image: apiModel.image,
      text: apiModel.text,
    );
  }
}
