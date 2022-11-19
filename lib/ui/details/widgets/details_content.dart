import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbers_light/domain/model/number_light.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_state.dart';
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
          return _getItemContent(localizations: localizations, item: state.item);
        } else if (state is DetailsLoadingState) {
          return const LoadingContent();
        } else if (state is DetailsErrorState) {
          return Center(child: Text(localizations.itemNotFoundError));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _getItemContent({required AppLocalizations localizations, required NumberLight? item}) {
    if (item != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item.image,
              height: 400,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(item.name),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
