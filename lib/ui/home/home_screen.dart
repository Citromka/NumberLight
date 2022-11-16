import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_light/getit_root.dart';
import 'package:numbers_light/ui/home/home_bloc.dart';
import 'package:numbers_light/ui/home/home_event.dart';
import 'package:numbers_light/ui/home/home_state.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';
import 'package:numbers_light/ui/home/widgets/number_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(localizations.appTitle),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();
          return state is! HomeLoadedState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : NumberList(
                  items: state.list,
                  onItemFocused: (item) {
                    bloc.add(HomeItemStateChanged(item: item, state: NumberLightSelectionState.focused));
                  },
                  onItemSelected: (item) {
                    bloc.add(HomeItemStateChanged(item: item, state: NumberLightSelectionState.selected));
                  },
                );
        },
      ),
    );
  }
}
