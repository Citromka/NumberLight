import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/widgets/details_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.detailsTitle),
        leading: BackButton(onPressed: () {
          ModalRoute.of(context)?.navigator?.pop(true);
        }),
      ),
      body: BlocProvider<DetailsBloc>.value(
        value: GetIt.I.get()..add(DetailsSelected(id)),
        child: const DetailsContent(),
      ),
    );
  }
}
