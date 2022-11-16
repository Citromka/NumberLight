import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';

part 'number_light_presentation.freezed.dart';

@freezed
class NumberLightPresentation with _$NumberLightPresentation {
  const factory NumberLightPresentation({
    required String id,
    required String name,
    required String image,
    required NumberLightSelectionState state
  }) = _NumberLightPresentation;
}