import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';

extension NumberLightExtension on NumberLight {
  NumberLightPresentation toNumberLightPresentation() {
    return NumberLightPresentation(
      id: id,
      name: name,
      image: image,
      state: NumberLightSelectionState.normal
    );
  }
}