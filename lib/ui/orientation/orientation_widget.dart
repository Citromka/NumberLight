import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_event.dart';

class OrientationWidget extends StatelessWidget {
  final Widget child;

  const OrientationWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (ctx, orientation) {
      final bloc = context.read<OrientationBloc>();
      bloc.add(OrientationChanged(orientation));
      return child;
    });
  }
}
