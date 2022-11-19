import 'package:flutter/material.dart';
import 'package:numbers_light/ui/home/model/number_light_presentation.dart';
import 'package:numbers_light/ui/home/widgets/number_list_item.dart';

class NumberList extends StatelessWidget {
  final List<NumberLightPresentation> items;
  final Function(NumberLightPresentation) onItemSelected;

  const NumberList({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return NumberListItem(
          name: item.name,
          imageUrl: item.image,
          state: item.state,
          onSelect: () {
            onItemSelected(item);
          },
        );
      },
    );
  }
}
