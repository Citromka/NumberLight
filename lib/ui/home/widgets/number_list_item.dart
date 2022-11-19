import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';

class NumberListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final NumberLightSelectionState state;
  final Function onSelect;

  const NumberListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.state,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect();
      },
      child: Card(
        color: _getColorByState(state),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(name),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                  placeholder: (context, _) {
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorByState(NumberLightSelectionState state) {
      switch(state) {
        case NumberLightSelectionState.normal:
          return Colors.white;
        case NumberLightSelectionState.focused:
          return Colors.blueGrey;
        case NumberLightSelectionState.selected:
          return Colors.blue;
      }
    }
}