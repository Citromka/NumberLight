import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_light_api_model.freezed.dart';
part 'number_light_api_model.g.dart';

@freezed
class NumberLightApiModel with _$NumberLightApiModel {
  const factory NumberLightApiModel({
    required String name,
    required String image
  }) = _NumberLightApiModel;

  factory NumberLightApiModel.fromJson(Map<String, Object?> json)
  => _$NumberLightApiModelFromJson(json);
}