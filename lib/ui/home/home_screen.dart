import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_light/domain/model/base/error_type.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/navigation/details_route.dart';
import 'package:numbers_light/ui/details/widgets/details_content.dart';
import 'package:numbers_light/ui/home/home_bloc.dart';
import 'package:numbers_light/ui/home/home_event.dart';
import 'package:numbers_light/ui/home/home_state.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';
import 'package:numbers_light/ui/home/widgets/number_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numbers_light/ui/widgets/error_row.dart';
import 'package:numbers_light/ui/widgets/loading_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailsBloc detailsBloc = context.read();
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) async {
          if (state is HomeItemSelectionUpdated) {
            if (state.orientation == Orientation.portrait) {
              await ModalRoute.of(context)
                  ?.navigator
                  ?.pushNamed(DetailsRoute.details,
                      arguments: state.selectedItemName)
                  .then((value) {
                if (value is bool && value) {
                  context.read<HomeBloc>().add(HomeReturnEvent());
                }
              });
            }
            detailsBloc.add(DetailsSelectedEvent(state.selectedItemName));
          }
        },
        builder: (context, state) {
          return state is! HomeLoadedState
              ? const LoadingContent()
              : state.errorType == null
                  ? _getWidgetBasedOnOrientation(
                      context: context,
                      state: state,
                    )
                  : _showError(
                      context: context,
                      localizations: localizations,
                      errorType: state.errorType!,
                    );
        },
      ),
    );
  }

  Widget _showError({
    required BuildContext context,
    required AppLocalizations localizations,
    required ErrorType errorType,
  }) {
    return ErrorRow(
      errorType: errorType,
      onRefreshPressed: () {
        context.read<HomeBloc>().add(HomeRefreshEvent());
      }
    );
  }

  Widget _getWidgetBasedOnOrientation({
    required BuildContext context,
    required HomeLoadedState state,
  }) {
    if (state.orientation == Orientation.landscape) {
      return Row(
        children: [
          Expanded(
            child: _list(context, state),
          ),
          const Flexible(
            child: DetailsContent(),
          )
        ],
      );
    } else {
      return _list(context, state);
    }
  }

  Widget _list(BuildContext context, HomeLoadedState state) {
    final bloc = context.read<HomeBloc>();
    return NumberList(
      items: state.list,
      onItemSelected: (item) {
        final event = HomeItemStateChanged(
          item: item,
          state: state.orientation == Orientation.portrait
              ? NumberLightSelectionState.selected
              : NumberLightSelectionState.focused,
        );
        bloc.add(event);
      },
    );
  }
}
