import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:numbers_light/data/network/model/number_light_api_model.dart';
import 'package:uuid/uuid.dart';

part 'number_light.freezed.dart';

part 'number_light.g.dart';

@freezed
class NumberLight with _$NumberLight {
  const factory NumberLight(
      {required String id,
      required String name,
      required String image}) = _NumberLight;

  factory NumberLight.fromJson(Map<String, Object?> json) =>
      _$NumberLightFromJson(json);

  factory NumberLight.fromApiModel(NumberLightApiModel apiModel) {
    return NumberLight(
      id: const Uuid().v4(),
      name: apiModel.name,
      image: apiModel.image,
    );
  }
}
