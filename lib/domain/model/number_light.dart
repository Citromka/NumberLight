import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_light.freezed.dart';
part 'number_light.g.dart';

@freezed
class NumberLight with _$NumberLight {
  const factory NumberLight({
    required String id,
    required String name,
    required String image
  }) = _NumberLight;

  factory NumberLight.fromJson(Map<String, Object?> json)
  => _$NumberLightFromJson(json);
}