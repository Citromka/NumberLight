import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_light/domain/model/number_light_detail.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/details_state.dart';
import 'package:numbers_light/ui/widgets/error_row.dart';
import 'package:numbers_light/ui/widgets/loading_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsContent extends StatelessWidget {
  const DetailsContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsBloc, DetailsState>(
      listenWhen: (_, state) => state.isListenable(),
      buildWhen: (_, state) => !state.isListenable(),
      listener: (context, state) {
        if (state is DetailsNavigateBack) {
          ModalRoute.of(context)?.navigator?.pop(false);
        }
      },
      builder: (context, state) {
        final localizations = AppLocalizations.of(context)!;
        if ((state is DetailsLoadedState)) {
          return _getItemContent(
              localizations: localizations, item: state.item);
        } else if (state is DetailsLoadingState) {
          return const LoadingContent();
        } else if (state is DetailsErrorState) {
          if (state.errorType != null) {
            return ErrorRow(
              errorType: state.errorType!,
              onRefreshPressed: () {
                context.read<DetailsBloc>().add(DetailsRefreshedEvent());
              },
            );
          } else {
            return Center(child: Text(localizations.itemNotFoundError));
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _getItemContent(
      {required AppLocalizations localizations,
      required NumberLightDetail? item}) {
    if (item != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item.image,
              height: 400,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(item.name),
            const SizedBox(
              height: 24.0,
            ),
            Text(item.text),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
