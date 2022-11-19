import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_light_detail_api_model.freezed.dart';
part 'number_light_detail_api_model.g.dart';

@freezed
class NumberLightDetailApiModel with _$NumberLightDetailApiModel {
  const factory NumberLightDetailApiModel({
    required String name,
    required String text,
    required String image
  }) = _NumberLightDetailApiModel;

  factory NumberLightDetailApiModel.fromJson(Map<String, Object?> json)
  => _$NumberLightDetailApiModelFromJson(json);
}